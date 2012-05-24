require 'spec_helper'

describe DashboardController do
  context "with user logged in" do
    login_user
    
    def valid_token_for_user(user_id)
      {:name => 'ab23c', :description => 'My site tracker', :user_id => user_id}
    end
    
    it "should have a current user" do
      subject.current_user.should_not be_nil
    end
  
    it "should display the index page" do
      get 'index'
      response.should be_ok
    end
    
    it "displays the user's tracking tokens" do
      tokens = [Token.create!(valid_token_for_user(1)), Token.create!(valid_token_for_user(1))]
      get 'index'
      assigns(:tokens).should eq(tokens)
    end
    
    it "should not show another user's tracking tokens" do
      my_tokens = [Token.create!(valid_token_for_user(1))]
      other_user = FactoryGirl.create(:user)
      other_user_tokens = [Token.create!(valid_token_for_user(2))]
      get 'index'
      assigns(:tokens).should eq(my_tokens)
    end
  end
  
  context "without a user logged in" do
    it "should authenticate a user" do
      get 'index'
      response.should redirect_to new_user_session_path
    end
  end
end
