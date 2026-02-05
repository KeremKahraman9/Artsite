module ApplicationHelper
  include Pagy::Frontend

  def time_remaining_display(auction)
    return "Ended" unless auction.live?

    seconds = auction.time_remaining
    days = seconds / 86400
    hours = (seconds % 86400) / 3600
    minutes = (seconds % 3600) / 60

    if days > 0
      "#{days}d #{hours}h"
    elsif hours > 0
      "#{hours}h #{minutes}m"
    else
      "#{minutes}m"
    end
  end

  def price_display(amount)
    number_to_currency(amount, precision: 2)
  end

  def artwork_image_url(artwork, variant: :medium)
    if artwork.image.attached?
      case variant
      when :thumb
        artwork.image.variant(resize_to_fill: [300, 300])
      when :medium
        artwork.image.variant(resize_to_fill: [600, 600])
      when :large
        artwork.image.variant(resize_to_limit: [1200, 1200])
      else
        artwork.image
      end
    else
      "placeholder_art.jpg"
    end
  end
end
