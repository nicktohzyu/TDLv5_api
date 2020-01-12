class EntriesController < ApplicationController
    include CurrentUserConcern
    before_action :set_entry, only: [:show, :edit, :update, :destroy]
    def index
        @entries = Entry.where(user_id: @current_user.id)
        # if(params[:tag])
        #   @entries = @entries.tagged_with(params[:tag])
        # end
        render json: @entries
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

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
        @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
        params.require(:entry).permit(:content, :due_date, :user_id, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
    end
end
