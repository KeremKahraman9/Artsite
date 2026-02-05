class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @my_artworks = current_user.artworks.includes(:category, image_attachment: :blob).recent
    @my_auctions = current_user.auctions_as_seller.includes(artwork: [image_attachment: :blob]).order(created_at: :desc)
    @my_bids = current_user.bids.includes(auction: { artwork: [image_attachment: :blob] }).recent.limit(10)
    @watched_auctions = current_user.watched_auctions.includes(artwork: [:artist, { image_attachment: :blob }]).live
  end
end
