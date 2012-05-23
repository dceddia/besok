class Token < ActiveRecord::Base
  attr_accessible :description, :name, :url, :user_id
end
