class EpisodesController < ApplicationController
  resource :episode
  self.collection_actions << :upcoming

  def index
    @episodes = @episodes.past

    respond_to do |format|
      format.html
      format.json
      format.rss
    end
  end

  def upcoming
    @episodes = @episodes.future
  end

  def show
    respond_with @episode
  end

  private

  def model
    return super unless params[:id] == 'current'
    present Episode.current
  end
end
