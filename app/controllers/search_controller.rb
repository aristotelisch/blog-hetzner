class SearchController < ApplicationController
  def search
    if params[:query].nil?
      @articles = []
    else
      @articles = Article.search params[:query]
    end
  end
end
