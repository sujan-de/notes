class NotesController < ApplicationController
  before_action :correct_user
  def index
    @notes = current_user.notes
  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = Note.new(notes_params)
    @note.user = current_user
    if @note.save
      flash[:notice] = "Note has been created successfully"
      redirect_to user_notes_path(@user)
    else
      render "new"
    end
  end

  def edit
    @note = Note.find_by(id: params[:id])
  end

  def update
    @note = Note.where(id: params[:id]).first
    if @note.update_attributes(notes_params)
      flash[:notice] = "Note has been updated successfully"
      redirect_to user_notes_path(@user)
    else
      render "edit"
    end
  end

  def show
    @note = Note.where(id: params[:id]).first
  end

  def destroy
    @note = Note.where(id: params[:id]).first
    if @note.destroy
      flash[:notice] = "Note has been deleted successfully"
    else
      flash[:notice] = "There had been some problem, deleting the note"
    end
    redirect_to user_notes_path(@user)
  end

  private

  def correct_user
    @user = User.find_by(id: params[:user_id])
    redirect_to(user_path(current_user)) if current_user != @user
  end

  def notes_params
    notes_attributes = params.require(:note).permit(:title, :body, :tags)
    tags = notes_attributes["tags"].split(/[\s,]+/) if notes_attributes["tags"]
    title = notes_attributes["title"] if notes_attributes["title"]
    body = notes_attributes["body"] if notes_attributes["body"]
    return {title: title, body: body, tags: tags}
  end
end
