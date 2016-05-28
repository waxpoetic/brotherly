class EpisodesController < ApplicationController
  resource :episode

  def index
    @episodes = @episodes.latest
    respond_to do |format|
      format.html
      format.json
      format.rss
    end
  end

  def current
    @episode = Episode.current
    respond_with @episode
  end

  def show
    respond_with @episode
  end
end
