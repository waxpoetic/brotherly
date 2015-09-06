class EpisodesController < ApplicationController
  expose :episodes, scope: :latest, only: [:index]
  expose :episode, only: [:show]
  expose :current_episode, only: [:current] do
    Episode.current
  end

  def index
    respond_to do |format|
      format.html { respond_with episodes }
      format.rss  { render :podcast }
    end
  end

  def current
    respond_with current_episode
  end

  def show
    respond_with episode
  end
end
