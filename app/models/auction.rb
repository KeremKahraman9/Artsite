class Auction < ApplicationRecord
  belongs_to :artwork
  belongs_to :seller, class_name: "User", inverse_of: :auctions_as_seller
  has_many :bids, dependent: :destroy
  has_many :watchlists, dependent: :destroy
  has_many :watchers, through: :watchlists, source: :user

  enum :status, { pending: 0, active: 1, ended: 2, cancelled: 3 }

  validates :starting_price, presence: true, numericality: { greater_than: 0 }
  validates :current_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :ends_at_after_starts_at

  before_validation :set_current_price, on: :create

  scope :live, -> { where(status: :active).where("ends_at > ?", Time.current) }
  scope :ending_soon, -> { live.order(ends_at: :asc) }
  scope :recently_ended, -> { where(status: :ended).order(ends_at: :desc) }
  scope :upcoming, -> { where(status: :pending).where("starts_at > ?", Time.current).order(starts_at: :asc) }

  def time_remaining
    return 0 if ended? || cancelled?

    [(ends_at - Time.current).to_i, 0].max
  end

  def live?
    active? && ends_at > Time.current
  end

  def highest_bid
    bids.order(amount: :desc).first
  end

  def highest_bidder
    highest_bid&.bidder
  end

  def minimum_bid
    if bids.any?
      current_price + bid_increment
    else
      starting_price
    end
  end

  def bid_increment
    case current_price
    when 0..99 then 5
    when 100..499 then 10
    when 500..999 then 25
    when 1000..4999 then 50
    else 100
    end
  end

  def place_bid!(bidder, amount)
    return false if !live?
    return false if bidder == seller
    return false if amount < minimum_bid

    transaction do
      bid = bids.create!(bidder: bidder, amount: amount)
      update!(current_price: amount)
      bid
    end
  end

  def close!
    return unless live? || (active? && ends_at <= Time.current)

    update!(status: :ended)
  end

  private

  def set_current_price
    self.current_price ||= starting_price
  end

  def ends_at_after_starts_at
    return unless starts_at.present? && ends_at.present?

    if ends_at <= starts_at
      errors.add(:ends_at, "must be after start time")
    end
  end
end
