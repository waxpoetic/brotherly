class EpisodesController < ApplicationController
  resource :episode, scope: :latest

  def index
    respond_with episodes
  end

  def latest
    respond_with episodes.first
  end

  def podcast
    respond_to do |format|
      format.rss { render :podcast }
    end
  end

  def show
    respond_with episode, format: :rss
  end
end
