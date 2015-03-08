class ChangeArticlesDraftColumn < ActiveRecord::Migration
  def change
    change_column :articles, :draft, :boolean, :default => true
  end
end
