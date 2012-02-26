class AlbumImagesController < ApplicationController
  before_filter :authorize
  before_filter :fetch_album_image, :only => [:destroy, :promote, :demote, :move]

  # GET /albums/1/images/new
  # GET /albums/1/images/new.json
  def new
    @album_image = AlbumImage.new
    @album_image.album = Album.find(params[:album_id])
    redirect_to @album_image.album, :notice => 'That album already contains every image you have uploaded.' and return if @album_image.album.images_not_present.empty?

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @album_image }
    end
  end

  # POST /albums/1/images
  # POST /albums/1/images.json
  def create
    @album_image = AlbumImage.new
    @album_image.album = Album.find(params[:album_id])
    @album_image.image = Image.find(params[:album_image][:image_id])

    respond_to do |format|
      if @album_image.save
        format.html { redirect_to(@album_image.album, :notice => 'Image was successfully added to album.') }
        format.json  { render :json => @album_image, :status => :created, :location => @album_image.album }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @album_image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1/images/1
  # DELETE /albums/1/images/1.json
  def destroy
    @album_image.destroy

    respond_to do |format|
      format.html { redirect_to album_url(@album_image.album) }
      format.json  { head :ok }
    end
  end

  # POST /albums/1/images/1/promote
  # POST /albums/1/images/1/promote.json
  def promote
    @album_image.move_higher

    respond_to do |format|
      format.html { redirect_to(@album_image.album) }
      format.json  { head :ok }
    end
  end

  # POST /albums/1/images/1/demote
  # POST /albums/1/images/1/demote.json
  def demote
    @album_image.move_lower

    respond_to do |format|
      format.html { redirect_to(@album_image.album) }
      format.json  { head :ok }
    end
  end

  # POST /albums/1/images/1/move
  # POST /albums/1/images/1/move.json
  def move
    @album_image.insert_at params[:to].to_i

    respond_to do |format|
      format.html { redirect_to(@album_image.album) }
      format.json  { head :ok }
    end
  end

  protected

  def fetch_album_image
    @album_image = AlbumImage.where(:album_id => params[:album_id], :image_id => params[:id]).first
    raise ActiveRecord::RecordNotFound unless @album_image
  end
end
