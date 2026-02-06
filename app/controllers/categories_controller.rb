class CategoriesController < ApplicationController
  def show
    @category = Category.find_by!(slug: params[:id])
    @pagy, @artworks = pagy(
      @category.artworks.published.recent.includes(:artist, image_attachment: :blob)
    )
  end
end
