require 'spec_helper'

describe "tokens/show" do
  before(:each) do
    @token = assign(:token, FactoryGirl.create(:token))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
