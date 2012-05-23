class DashboardController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @tokens = Token.all
  end
end
