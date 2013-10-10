class User < ActiveRecord::Base
#  attr_accessible :firstname, :lastname, :email, :username
  has_many :articles
end
