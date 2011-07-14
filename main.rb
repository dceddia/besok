require 'sinatra'
require 'data_mapper'
require 'erb'
require 'rack-flash'
require 'sinatra/redirect_with_flash'

enable :sessions
use Rack::Flash, :sweep => true

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/besok.sqlite3")

require 'schema'

def shorten(str, max_length)
    if str.length > max_length
        str[0..max_length-1]
    else
        str
    end
end

def add_visit(token, request)
    page = Page.find(
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

post '/new' do
    page = Page.new(
        :name           => params[:name],
        :url            => params[:url],
        :description    => params[:description]
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

get '/check' do
    erb :check
end

get '/visit' do
    redirect '/'
end

get '/visit/:id' do
    add_visit(request)
    send_file 'blank.gif'
end
