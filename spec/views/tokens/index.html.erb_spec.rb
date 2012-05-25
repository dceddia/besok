require 'spec_helper'

describe "tokens/index" do
  before(:each) do
    assign(:tokens, [
      FactoryGirl.create(:token),
      FactoryGirl.create(:token)
    ])
  end

  it "renders a list of tokens" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
