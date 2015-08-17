class EpisodesController < ApplicationController
  resource :episode, scope: :latest

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
    respond_with episode, format: :rss
  end
end
