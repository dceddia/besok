require 'spec_helper'

describe "tokens/edit" do
  before(:each) do
    @token = assign(:token, FactoryGirl.create(:token))
  end

  it "renders the edit token form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tokens_path(@token), :method => "post" do
    end
  end
end
