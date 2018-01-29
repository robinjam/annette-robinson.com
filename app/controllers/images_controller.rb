class ImagesController < ApplicationController
  before_action :authorize, :except => :download
  skip_before_action :verify_authenticity_token, only: [:index]

  def index
    @images = Image.order(:title)
  end

  def new
    @image = Image.new
  end

  def edit
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(image_params)
    @image.save ?
      redirect_to(images_path, notice: 'Image was successfully created.') : render(:new)
  end

  def update
    @image = Image.find(params[:id])
    @image.update_attributes(image_params) ?
      redirect_to(images_path, notice: 'Image was successfully updated.') : render(:new)
  end

  def delete
    @image = Image.find(params[:id])
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to(images_url, :notice => 'Image was successfully deleted.')
  end

  private

  def image_params
    params.require(:image).permit(:title, :image)
  end
end
