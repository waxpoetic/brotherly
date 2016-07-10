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

  def show
    respond_with @episode
  end

  private

  def model
    return super unless params[:id] == 'current'
    Episode.current.decorate
  end
end
