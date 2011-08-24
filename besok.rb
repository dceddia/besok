require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'erb'
require 'rack-flash'
require 'sinatra/redirect_with_flash'
require 'bcrypt'

enable :sessions
use Rack::Flash, :sweep => true

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/besok.sqlite3")

require 'schema'

def shorten(str, max_length)
    str[0...max_length]
end

def authorized?
    session[:authorized]
end

def authorize!
    redirect '/login' unless authorized?
end

def logout!
    session[:authorized] = false
end

def add_visit(token, request)
    #page = Page.find(
    visit = Visit.new(
        :occurred_at        => Time.now,
        :ip                 => request.ip,
        :referrer           => request.referrer,
        :user_agent         => request.user_agent
    )
    if visit.save
        visit
    else
        puts "Visit did not save! errors:"
        visit.errors.each { |e| puts "   #{e}" }
        nil
    end
end

get '/' do
    erb :index
end
    
get '/new' do
    erb :new
end

get '/login' do
    redirect '/manage' if authorized?
    erb :login
end

post '/login' do
    redirect '/manage' if authorized?

    page = Page.first(:id => params[:token])
    puts "--- #{page}"
    if page and BCrypt::Password.new(page.password) == params[:password]
        session[:authorized] = true
        redirect '/manage'
    else
        redirect '/login', :error => "Token or Password was incorrect" unless page
    end
end

post '/new' do
    page = Page.new(
        :name           => params[:name],
        :url            => params[:url],
        :description    => params[:description],
        :password       => BCrypt::Password.create(params[:password])
    )
    if page and page.save
        session[:new_id] = page.id
        redirect '/welcome'
    else
        errors = ""
        page.errors.each do |field_errors|
            field_errors.each do |e|
                errors += "<div>#{e}</div>"
            end
        end
        redirect '/new', :error => errors
    end
end

get '/welcome' do
    @new_id = session[:new_id]
    erb :welcome
end

get '/manage' do
    erb :manage
end

get '/visit' do
    redirect '/'
end

get '/visit/:token' do |token|
    add_visit(token, request)
    send_file 'blank.gif'
end
