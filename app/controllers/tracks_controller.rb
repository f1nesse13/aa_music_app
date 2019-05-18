class TracksController < ApplicationController
  before_action :current_user_or_redirect

  def index
    @tracks = Track.all
    render :index
  end

  def show
    @track = Track.find(params[:id])
    @notes = Note.all
    @note = Note.new()
    if @track
      render :show
    else
      flash[:errors] = "Can't find that track."
      redirect_back
    end
  end

  def new
    @track = Track.new()
    @album_id = params[:album_id]
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)
    @album_id = params[:album_id]
    @albums = Album.all

    if @track.save
      flash[:notice] = "Successfully added"
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @album_id = params[:album_id]
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @album_id = params[:album_id]
    @albums = Album.all

    if @track.update(track_params)
      flash[:notice] = "Successfully updated"
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])

    if @track.destroy
      flash[:notice] = "Successfully deleted"
      redirect_to album_url(@track.album)
    else
      flash[:error] = "Cannot delete"
      redirect_back
    end
  end

  private

  def track_params
    params.require(:track).permit(:title, :bonus, :ord, :album_id, :lyrics)
  end
end
