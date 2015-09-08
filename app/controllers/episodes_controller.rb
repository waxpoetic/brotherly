class EpisodesController < ApplicationController
  expose :episodes, scope: :latest, only: [:index]
  expose :episode, only: [:show]
  expose :episode, only: [:current] do
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
    respond_with episode
  end

  def show
    respond_with episode
  end
end
