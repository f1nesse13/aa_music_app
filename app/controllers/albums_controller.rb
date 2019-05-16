class AlbumsController < ApplicationController
  before_action :current_user_or_redirect

  def index
    @albums = Album.all
    render :index
  end

  def show
    @album = Album.find(params[:id])
    @album_attributes = @album.attributes_for_show_page
    if @album
      render :show
    else
      flash[:errors] = "Cannot find that album"
      redirect_to albums_url
    end
  end

  def new
    @album = Album.new
    @bands = Band.all
    @band_id = params[:band_id]
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      flash[:notice] = "Successfully added album!"
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    @band_id = @album.band_id
    if @album
      render :edit
    else
      flash[:errors] = "Can't find that album!"
      redirect_back
    end
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      flash[:notice] = "Successfully updated!"
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])

    if @album.destroy
      flash[:notice] = "Successfully deleted"
      redirect_to albums_url
    else
      flash[:errors] = "Unable to delete"
      redirect_to album_url(@album)
    end
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :band_id, :studio)
  end
end
