require 'smallid'
require 'dm-sanitizer'

class Page
    include DataMapper::Resource
    
    property :id,           String, :key => true, :default => lambda { |r, p| SmallID.create(6) }
    property :name,         String
    property :url,          String, :length => 256
    property :description,  Text

    validates_length_of :name, :max => name.length, :message => "Name can't be longer than #{name.length} characters."
    validates_length_of :url, :max => url.length, :message => "URL can't be longer than #{url.length} characters."
    validates_length_of :description, :max => description.length, :message => "Description can't be longer than #{description.length} characters."

    has n, :visits
end

class Visit
    include DataMapper::Resource

    property :id,           Serial
    property :occurred_at,  DateTime
    property :ip,           String
    property :referrer,     String, :length => 256
    property :user_agent,   String, :length => 256

    belongs_to :page

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
