# frozen_string_literal: true
class PagesController < ApplicationController
  def home
    @current_episodes = EpisodesPresenter.new Episode.current
    @upcoming_episodes = EpisodesPresenter.new Episode.upcoming
    # TODO: Article.featured
    @features = Episode.featured + Performance.featured
  end
end
