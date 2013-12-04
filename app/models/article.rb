class Article < ActiveRecord::Base
  belongs_to :user
  include FriendlyId
  friendly_id :title, :use => :slugged
  validates_presence_of :title, :slug, :body

  default_scope { order("created_at DESC") }
end
