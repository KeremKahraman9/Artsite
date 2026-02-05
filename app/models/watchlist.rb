class Watchlist < ApplicationRecord
  belongs_to :user
  belongs_to :auction

  validates :user_id, uniqueness: { scope: :auction_id, message: "already watching this auction" }
end
