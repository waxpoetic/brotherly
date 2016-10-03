class PagesController < ApplicationController
  def home
    @featured = present Feature.latest(3)
    @articles = present Article.latest(5)
  end
end
