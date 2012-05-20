require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe "login process" do
    include Capybara::DSL
    include Rack::Test::Methods

    def setup
        Capybara.app = Sinatra::Application.new
    end

    #def app
    #    Sinatra::Application
    #end

    it "should allow a registered user to login" do
        visit '/login'
        fill_in 'name', "dave"
    end
end
