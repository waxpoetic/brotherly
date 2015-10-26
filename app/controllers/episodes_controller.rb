class EpisodesController < ApplicationController
  resource :episode, scope: :latest

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
