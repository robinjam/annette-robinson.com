class AlbumsController < ApplicationController
  before_filter :authorize, except: [:first, :show]

  def first
    flash.keep and redirect_to album_url(Album.ordered.first) if Album.count > 0
  end

  def show
    @album = Album.find(params[:id])
    if request.path != album_path(@album)
      redirect_to @album
    end
  end

  def new
    @album = Album.new
  end

  def edit
    @album = Album.find(params[:id])
  end

  def create
    @album = Album.new(album_params)
    @album.save ?
      redirect_to(@album, notice: 'Album was successfully created.') : render(:new)
  end

  def update
    @album = Album.find(params[:id])
    @album.update_attributes(album_params) ?
      redirect_to(@album, notice: 'Album was successfully updated.') : render(:new)
  end

  def delete
    @album = Album.find(params[:id])
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to(root_url, :notice => 'Album was successfully deleted.')
  end

  def move
    @album = Album.find(params[:id])
    @album.insert_at params[:to].to_i

    respond_to do |format|
      format.json { head :ok }
    end
  end

  private

  def album_params
    params.require(:album).permit(:title)
  end
end
