class AddDraftToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :draft, :boolean
    add_index :articles, :draft
  end
end
