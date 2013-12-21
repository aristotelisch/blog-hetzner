class Article < ActiveRecord::Base
  belongs_to :user
  include FriendlyId
  friendly_id :title, :use => :slugged
  validates_presence_of :title, :slug, :body

  default_scope { order("created_at DESC") }
  before_save :make_excerpt

  def make_excerpt
    if self.excerpt.blank?
      self.update_attributes(excerpt: self.body.slice(0,400))
    else
      self.excerpt
    end
  end

end
