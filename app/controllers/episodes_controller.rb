class EpisodesController < ApplicationController
  expose :episodes, scope: :latest, only: [:index, :latest]
  expose :episode, only: [:show]

  def index
    respond_to do |format|
      format.html { respond_with episodes }
      format.rss  { render :podcast }
    end
  end

  def latest
    respond_with episodes.first
  end

  def show
    respond_with episode
  end
end
