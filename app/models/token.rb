class Token < ActiveRecord::Base
  attr_accessible :description, :name, :url, :user_id
  validates :name, :presence => true
  validates :user_id, :presence => true
  validates :description, :presence => true
  before_validation :generate_name
  belongs_to :user
  
  def generate_name
    # So many options...
    # http://blog.logeek.fr/2009/7/2/creating-small-unique-tokens-in-ruby
    self.name = rand(36**8).to_s(36)
  end
end
