require File.join(File.dirname(__FILE__), "spec_helper.rb")

describe "Besok app" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    it 'displays the index page' do
        page_should_contain('/', 'Besok')
    end

    it 'displays the signup page' do
        page_should_contain('/new', 'New Page')
    end

    it 'displays the login page' do
        page_should_contain('/login', 'Login')
    end
end
