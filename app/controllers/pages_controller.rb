# frozen_string_literal: true
class PagesController < ApplicationController
  def home
    @current_episodes = EpisodesPresenter.new Episode.current
    @upcoming_episodes = EpisodesPresenter.new Episode.upcoming
    @past_episodes = EpisodesPresenter.new Episode.recent.limit(5)
    # TODO: Article.featured
    @features = Episode.featured + Performance.featured
  end
end
