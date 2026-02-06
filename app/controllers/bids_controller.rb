class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auction

  def create
    amount = bid_params[:amount].to_f
    @bid = @auction.place_bid!(current_user, amount)

    if @bid
      redirect_to @auction, notice: "Bid placed successfully!"
    else
      redirect_to @auction, alert: "Could not place bid. Ensure your bid meets the minimum amount and the auction is still active."
    end
  end

  private

  def set_auction
    @auction = Auction.find(params[:auction_id])
  end

  def bid_params
    params.require(:bid).permit(:amount)
  end
end
