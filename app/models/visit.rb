class Visit < ActiveRecord::Base
  attr_accessible :ip_address, :referer, :token_id, :user_agent
  belongs_to :token
end
