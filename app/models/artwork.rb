class Artwork < ApplicationRecord
  belongs_to :artist, class_name: "User", inverse_of: :artworks
  belongs_to :category
  has_many :auctions, dependent: :destroy

  has_one_attached :image

  enum :status, { draft: 0, published: 1, archived: 2 }

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  scope :featured, -> { where(featured: true) }
  scope :published, -> { where(status: :published) }
  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[title description artist_id category_id status medium year featured created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[artist category]
  end

  def to_param
    slug
  end

  def active_auction
    auctions.where(status: :active).order(created_at: :desc).first
  end

  private

  def generate_slug
    base_slug = title.parameterize
    self.slug = base_slug
    counter = 1
    while Artwork.exists?(slug: self.slug)
      self.slug = "#{base_slug}-#{counter}"
      counter += 1
    end
  end
end
