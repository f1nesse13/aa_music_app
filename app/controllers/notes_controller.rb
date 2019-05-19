class NotesController < ApplicationController
  def new
    @notes = Note.all
    @note = Note.new()
  end

  def create
    @note = Note.new(note_params)
    @track = Track.find(params[:track_id])
    @note.user_id = current_user.id
    @note.track_id = @track.id
    if @note.save
      flash[:notice] = "Note Added"
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages.to_sentence
      redirect_to track_url(@track)
    end
  end

  def edit
    @note = Note.find(params[:id])
    @track = Track.find(params[:track_id])
    render :edit
  end

  def update
    @note = Note.find(params[:id])
    @track = Track.find(params[:track_id])
    if @note.update(note_params)
      flash[:notice] = "Note edited"
      redirect_to track_url(@track)
    else
      flash[:errors] = @note.errors.full_messages.to_sentence
      redirect_to track_url(@track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @track = Track.find(params[:track_id])
    if !@note.nil? && current_user.id.to_i == @note.user_id.to_i
      @note.destroy
      flash[:notice] = "Deleted note"
      redirect_to track_url(@track)
    else
      render plain: "403 Forbidden"
    end
  end

  def note_params
    params.require(:note).permit(:body)
  end
end
