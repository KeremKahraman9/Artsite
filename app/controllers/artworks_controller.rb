class ArtworksController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  before_action :authorize_artist!, only: [:edit, :update, :destroy]

  def index
    @q = Artwork.published.ransack(params[:q])
    @q.sorts = "created_at desc" if @q.sorts.empty?
    scope = @q.result.includes(:artist, :category, image_attachment: :blob)

    if params[:category].present?
      @category = Category.find_by(slug: params[:category])
      scope = scope.where(category: @category) if @category
    end

    @pagy, @artworks = pagy(scope)
    @categories = Category.ordered
  end

  def show
    @active_auction = @artwork.active_auction
    @related_artworks = Artwork.published
      .where(category: @artwork.category)
      .where.not(id: @artwork.id)
      .includes(:artist, image_attachment: :blob)
      .limit(4)
  end

  def new
    @artwork = current_user.artworks.build
    @categories = Category.ordered
  end

  def create
    @artwork = current_user.artworks.build(artwork_params)
    @artwork.status = :published

    if @artwork.save
      redirect_to @artwork, notice: "Artwork created successfully."
    else
      @categories = Category.ordered
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.ordered
  end

  def update
    if @artwork.update(artwork_params)
      redirect_to @artwork, notice: "Artwork updated successfully."
    else
      @categories = Category.ordered
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @artwork.destroy
    redirect_to artworks_path, notice: "Artwork removed.", status: :see_other
  end

  private

  def set_artwork
    @artwork = Artwork.find_by!(slug: params[:id])
  end

  def artwork_params
    params.require(:artwork).permit(:title, :description, :category_id, :medium, :dimensions, :year, :image, :featured)
  end

  def authorize_artist!
    unless @artwork.artist == current_user || current_user.admin?
      redirect_to artworks_path, alert: "Not authorized."
    end
  end
end
