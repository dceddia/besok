require 'rubygems'
require 'main'
require 'capybara'
require 'capybara/dsl'
require 'test/unit'

class BesokTest < Test::Unit::TestCase
    include Capybara

    def setup
        Capybara.app = Sinatra::Application.new
    end

    def test_visit_home
        visit '/'
        assert page.has_content?('Besok')
    end

    def test_visit_new
        visit '/new'
        assert page.has_content?('New Page')
    end

    def test_account_creation
        visit '/new'
        fill_in 'name', :with => 'dave'
        fill_in 'password', :with => 'test'
        fill_in 'url', :with => 'http://binarynirvana.com'
        fill_in 'description', :with => 'optional, but supplied'
        click_button 'submit'
        assert page.has_content?('Welcome!')
    end
end

