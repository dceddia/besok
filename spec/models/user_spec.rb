require 'spec_helper'

describe User do
  def required_attributes
    {:username => 'user', :email => 'user@user.com', :password => 'password'}
  end
  
  it "should work with username, email, and password" do
    user = User.new(required_attributes)
    user.should be_valid
  end
  
  it "should not work with a missing username" do
    attrs = required_attributes
    attrs.delete(:username)
    user = User.new(attrs)
    user.should_not be_valid
  end
  
  it "should not work with a missing email" do
    attrs = required_attributes
    attrs.delete(:email)
    user = User.new(attrs)
    user.should_not be_valid
  end

  it "should not work with a missing password" do
    attrs = required_attributes
    attrs.delete(:password)
    user = User.new(attrs)
    user.should_not be_valid
  end
end
