class TagsController < ApplicationController
  include CurrentUserConcern
  before_action :set_tag, only: [:destroy]
  before_action :set_entry, only: [:index, :create]

  def index
    @tags = @entry.tags
    render json: @tags
  end

  # def show
  # end

  # POST /tags
  # POST /tags.json
  def create
    # @tag = Tag.new(tag_params)
    @tag = @entry.tags.new(tag_params)
    if @tag.save
      render json: @tag
    else 
      render json: { error: @tag.errors.full_messages }, status: 400
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    if @tag
      if @tag.destroy
        render json: { message: 'Tag deleted' }, status: 200
      else
        render json: { error: @tag.errors.full_messages }, status: 400
      end
    else
      render json: { error: 'Tag not found' }, status: 404 #correct http code?
    end
  end

  private
    def set_entry
      @entry = Entry.find(params[:entry_id])
    end

    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:content, :entry_id)
    end
end
