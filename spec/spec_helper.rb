require File.join(File.dirname(__FILE__), "..", "besok.rb")
require 'rubygems'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

set :environment, :test
set :logging, false
set :raise_errors, true
set :run, false

def page_should_contain(page, string)
    get page
    last_response.should be_ok
    last_response.body.should include(string)
end
