class AlbumImagesController < ApplicationController
  before_filter :authorize
  before_filter :fetch_album_image, only: [:destroy, :move]

  def new
    @album_image = AlbumImage.new
    @album_image.album = Album.find(params[:album_id])
    redirect_to @album_image.album, notice: 'That album already contains every image you have uploaded.' and return if @album_image.album.images_not_present.empty?
  end

  def create
    @album_image = AlbumImage.new
    @album_image.album = Album.find(params[:album_id])
    @album_image.image = Image.find(params[:album_image][:image_id])
    @album_image.save ?
      redirect_to(@album_image.album, notice: 'Image was successfully added to album.') : render(:new)
  end

  def destroy
    @album_image.destroy
    respond_to do |format|
      format.html { redirect_to album_url(@album_image.album) }
      format.js { head :ok }
    end
  end

  def move
    @album_image.insert_at params[:to].to_i

    respond_to do |format|
      format.json { head :ok }
    end
  end

  protected

  def fetch_album_image
    @album_image = AlbumImage.where(:album_id => params[:album_id], :image_id => params[:id]).first
    raise ActiveRecord::RecordNotFound unless @album_image
  end
end
