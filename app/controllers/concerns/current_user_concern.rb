module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    @current_user = User.first
    # puts "in currentUserConcern set_current_user"
    # puts session[:user_id]
    # if session[:user_id]
    #   @current_user = User.find(session[:user_id])
    # end
  end
end
