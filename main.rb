require 'sinatra'
require 'data_mapper'
require 'erb'

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/besok.sqlite3")

def shorten(str, max_length)
    if str.length > max_length
        str[0..max_length-1]
    else
        str
    end
end

class Visit
    include DataMapper::Resource

    property :id,           Serial
    property :occurred_at,  DateTime
    property :ip,           String
    property :referrer,     String, :length => 256
    property :user_agent,   String, :length => 256

    before :valid?, :cap_user_agent_length
    before :valid?, :cap_referrer_length

    def cap_user_agent_length(context = :default)
        self.user_agent = shorten(self.user_agent, Visit.user_agent.length)
    end

    def cap_referrer_length(context = :default)
        self.referrer = shorten(self.referrer, Visit.referrer.length)
    end

    def to_s
        "#{@id}, #{@occurred_at}, #{@ip}, #{@referrer}, #{@user_agent}"
    end
end

DataMapper.finalize
DataMapper.auto_upgrade!

def add_visit(request)
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

get '/track' do
    erb :track
end

get '/visit' do
    add_visit(request)
    send_file 'blank.gif'
end

get '/views' do
    Visit.count.to_s
end
