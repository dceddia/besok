class Token < ActiveRecord::Base
  attr_accessible :description, :name, :url, :user_id
  validates :name, :presence => true
  validates :user_id, :presence => true
  validates :description, :presence => true
end
