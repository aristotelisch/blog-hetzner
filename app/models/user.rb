class User < ActiveRecord::Base
#  attr_accessible :firstname, :lastname, :email, :username
  has_secure_password
  validates_uniqueness_of :email, :username
  
  has_many :articles
end
