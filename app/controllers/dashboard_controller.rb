class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @tokens = Token.find_all_by_user_id(current_user.id)
  end
end
