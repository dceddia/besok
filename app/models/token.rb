class Token < ActiveRecord::Base
  attr_accessible :description, :name, :url, :user_id
  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true
  validates :description, :presence => true
  before_validation :generate_name
  belongs_to :user
  has_many :visits
  
  def generate_name
    # So many options...
    # http://blog.logeek.fr/2009/7/2/creating-small-unique-tokens-in-ruby
    self.name = rand(36**8).to_s(36) if self.new_record?
  end
  
  def to_param
    self.name
  end
  
  def self.from_param(param)
    find_by_name!(param)
  end
end
