class HomeController < ApplicationController
  def index
    @featured_artworks = Artwork.published.featured.includes(:artist, :category, image_attachment: :blob).limit(6)
    @live_auctions = Auction.live.includes(artwork: [:artist, :category, { image_attachment: :blob }]).ending_soon.limit(4)
    @recent_artworks = Artwork.published.recent.includes(:artist, :category, image_attachment: :blob).limit(8)
    @categories = Category.ordered
  end
end
