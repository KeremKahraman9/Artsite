class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :artworks, foreign_key: :artist_id, dependent: :destroy, inverse_of: :artist
  has_many :auctions_as_seller, class_name: "Auction", foreign_key: :seller_id, dependent: :destroy, inverse_of: :seller
  has_many :bids, foreign_key: :bidder_id, dependent: :destroy, inverse_of: :bidder
  has_many :watchlists, dependent: :destroy
  has_many :watched_auctions, through: :watchlists, source: :auction

  has_one_attached :avatar

  enum :role, { member: 0, artist: 1, admin: 2 }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }

  def full_name
    "#{first_name} #{last_name}"
  end

  def display_name
    username
  end

  def can_sell?
    artist? || admin?
  end
end
