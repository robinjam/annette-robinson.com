class ImagesController < ApplicationController
  before_filter :authorize, :except => :download

  def index
    @images = Image.all(:order => 'title')
  end

  def new
    @image = Image.new
  end

  def edit
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(params[:image])
    @image.save ?
      redirect_to(images_path, notice: 'Image was successfully created.') : render(:new)
  end

  def update
    @image = Image.find(params[:id])
    @image.update_attributes(params[:image]) ?
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

  def download
    head(:bad_request) and return if params[:style].downcase == 'original' && !admin?
    
    image = Image.find(params[:id])
    path = image.image.path(params[:style])
    head(:bad_request) and return unless File.exist?(path)

    send_file path, :type => image.image.content_type, :disposition => 'inline'
  end
end
