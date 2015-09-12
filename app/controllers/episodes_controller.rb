class EpisodesController < ApplicationController
  expose :episodes, scope: :latest
  expose :episode
  expose :current_episode do
    Episode.current.decorate
  end

  def index
    respond_to do |format|
      format.html
      format.json
      format.rss
    end
  end

  def current
    respond_with current_episode
  end

  def show
    respond_with episode
  end
end
