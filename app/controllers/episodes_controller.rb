class EpisodesController < ApplicationController
  resource :episode

  def index
    respond_to do |format|
      format.html do
        @episodes = @episodes.latest
      end
      format.json { render json: @episodes }
      format.rss do
        @podcast = PodcastDecorator.decorate(
          collection.latest.in_podcast
        )
      end
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
