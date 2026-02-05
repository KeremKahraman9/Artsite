class AuctionsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: [:new, :create, :watch, :unwatch]
  before_action :set_auction, only: [:show, :watch, :unwatch]

  def index
    scope = Auction.includes(artwork: [:artist, :category, { image_attachment: :blob }])

    case params[:filter]
    when "ending_soon"
      scope = scope.live.ending_soon
    when "upcoming"
      scope = scope.upcoming
    when "ended"
      scope = scope.recently_ended
    else
      scope = scope.live.ending_soon
    end

    @pagy, @auctions = pagy(scope)
    @filter = params[:filter] || "live"
  end

  def show
    @artwork = @auction.artwork
    @bids = @auction.bids.includes(:bidder).highest_first.limit(10)
    @bid = Bid.new
    @watching = current_user&.watchlists&.exists?(auction: @auction)
  end

  def new
    @artwork = Artwork.find_by!(slug: params[:artwork_id])
    unless @artwork.artist == current_user || current_user.admin?
      redirect_to artworks_path, alert: "Not authorized."
      return
    end
    @auction = @artwork.auctions.build(seller: current_user)
  end

  def create
    @artwork = Artwork.find_by!(slug: params[:artwork_id])
    unless @artwork.artist == current_user || current_user.admin?
      redirect_to artworks_path, alert: "Not authorized."
      return
    end

    @auction = @artwork.auctions.build(auction_params)
    @auction.seller = current_user

    if @auction.save
      redirect_to @auction, notice: "Auction created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def watch
    current_user.watchlists.find_or_create_by(auction: @auction)
    redirect_to @auction, notice: "Added to watchlist."
  end

  def unwatch
    current_user.watchlists.find_by(auction: @auction)&.destroy
    redirect_to @auction, notice: "Removed from watchlist."
  end

  private

  def set_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:starting_price, :reserve_price, :starts_at, :ends_at).tap do |p|
      p[:status] = :active if p[:starts_at].present? && Time.zone.parse(p[:starts_at].to_s) <= Time.current
    end
  end
end
