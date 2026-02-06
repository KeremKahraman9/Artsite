class Bid < ApplicationRecord
  belongs_to :auction, counter_cache: true
  belongs_to :bidder, class_name: "User", inverse_of: :bids

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :amount_exceeds_current_price, on: :create

  scope :recent, -> { order(created_at: :desc) }
  scope :highest_first, -> { order(amount: :desc) }

  private

  def amount_exceeds_current_price
    return unless auction.present? && amount.present?

    if amount < auction.minimum_bid
      errors.add(:amount, "must be at least #{auction.minimum_bid}")
    end
  end
end
