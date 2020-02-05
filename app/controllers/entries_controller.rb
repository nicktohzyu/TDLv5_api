class EntriesController < ApplicationController
  include CurrentUserConcern
  before_action :set_entry, only: [:show, :update, :destroy]
  def index
    @entries = Entry.where(user_id: @current_user.id)
    render json: @entries, include:['tags']
  end
  
  def show
    render json: @entry
  end
  
  def create
    @entry = @current_user.entries.new(entry_params)
    if @entry.save
      render json: @entry
    else 
      render json: { error: @entry.errors.full_messages }, status: 400
    end
  end

  def update
    if @entry
      if @entry.update(entry_params)
        render json: { message: 'Entry updated' }, status: 200
      else 
        render json: { error: @entry.errors.full_messages }, status: 400
      end
    else
      render json: { error: 'Entry not found' }, status: 404 #correct http code?
    end
  end

  def destroy
    if @entry
      if @entry.destroy
        render json: { message: 'Entry deleted' }, status: 200
      else
        render json: { error: @entry.errors.full_messages }, status: 400
      end
    else
      render json: { error: 'Entry not found' }, status: 404 #correct http code?
    end
  end
  private
  def set_entry
    @entry = Entry.find(params[:id])
  end
  
  def entry_params
    params.require(:entry).permit(:content, :due_date, :done, :user_id, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end
end
