class BandsController < ApplicationController
  before_action :current_user_or_redirect

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    @albums = Album.where(band_id: params[:id])
    if @band
      render :show
    else
      flash[:errors] = "Cannot find that band"
      redirect_to cats_url
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      flash[:notice] = "Successfully updated"
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    if @band.destroy
      flash[:notice] = "Successfully deleted #{@band.name}"
      redirect_to bands_url
    else
      flash[:errors] = "Unable to delete band"
      redirect_to band_url(@band)
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
