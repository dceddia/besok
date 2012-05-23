require 'spec_helper'

describe DashboardController do
  context "with user logged in" do
    login_user
  
    it "should have a current user" do
      subject.current_user.should_not be_nil
    end
  
    it "should display the index page" do
      get 'index'
      response.should be_ok
    end
    
    it "displays the user's tracking tokens" do
      Token.should_receive(:all)
      get 'index'
    end
  end
  
  context "without a user logged in" do
    it "should authenticate a user" do
      get 'index'
      response.should redirect_to new_user_session_path
    end
  end
end
