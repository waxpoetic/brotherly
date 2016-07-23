class EpisodesController < ApplicationController
  resource :episode, scope: :latest

  def index
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
    present Episode.current
  end
end
