class AlbumsController < ApplicationController
  before_filter :authorize, :except => [:first, :show]

  # GET /
  def first
    flash.keep and redirect_to album_url(Album.ordered.first) if Album.count > 0
  end

  # GET /albums
  # GET /albums.xml
  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to(@album, :notice => 'Album was successfully created.') }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to(@album, :notice => 'Album was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /albums/1/delete
  def delete
    @album = Album.find(params[:id])
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(root_url, :notice => 'Album was successfully deleted.') }
      format.xml  { head :ok }
    end
  end

  # POST /albums/1/promote
  # POST /albums/1/promote.xml
  def promote
    @album = Album.find(params[:id])
    @album.move_higher

    respond_to do |format|
      format.html { redirect_to(@album) }
      format.xml  { head :ok }
    end
  end

  # POST /albums/1/demote
  # POST /albums/1/demote.xml
  def demote
    @album = Album.find(params[:id])
    @album.move_lower

    respond_to do |format|
      format.html { redirect_to(@album) }
      format.xml  { head :ok }
    end
  end

  # POST /albums/1/move
  # POST /albums/1/move.xml
  def move
    @album = Album.find(params[:id])
    @album.insert_at params[:to]

    respond_to do |format|
      format.html { redirect_to(@album) }
      format.xml  { head :ok }
    end
  end
end
