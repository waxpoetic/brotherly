class EpisodesController < ApplicationController
  resource :episode

  def index
    respond_to do |format|
      format.html
      format.json
      format.rss
    end
  end

  def show
    respond_with episode
  end
end
