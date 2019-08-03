# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @current_episodes = EpisodesPresenter.new Episode.current
    @upcoming_episodes = EpisodesPresenter.new Episode.upcoming
    @past_performances = PerformancesPresenter.new(
      Performance.where(episode: Episode.recent).where.not(video_url: nil).order('created_at DESC')
    )
    # TODO: Article.featured
    @features = Episode.featured + Performance.featured
  end
end
