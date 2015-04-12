require 'elasticsearch/model'

class Article < ActiveRecord::Base
  include FriendlyId
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  mount_uploader :featured_image, FeatureImageUploader

  belongs_to :user

  friendly_id :title, :use => :slugged

  validates_presence_of :title, :slug, :body

  default_scope { order("created_at DESC") }
  before_save :make_excerpt

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
      indexes :body, analyzer: 'english'
      indexes :draft
    end
  end

  def make_excerpt
    self.excerpt = self.body.slice(0,400)
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        query: {
          filtered: {
            query: {
              query_string: {
                query: query
              }
            },
            filter: {
              term: {
                draft: false
              }
            }
          }
        }
      }
    )
  end
end

# Delete the previous articles index in Elasticsearch
Article.__elasticsearch__.client.indices.delete index: Article.index_name rescue nil
 
# Create the new index with the new mapping
Article.__elasticsearch__.client.indices.create \
  index: Article.index_name,
  body: { settings: Article.settings.to_hash, mappings: Article.mappings.to_hash }

Article.import # to auto sync model with elastic search
