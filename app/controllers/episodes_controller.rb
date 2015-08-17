class EpisodesController < ApplicationController
  resource :episode, scope: :latest

  def latest
    respond_with episodes.first
  end

  def index
    respond_with episodes
  end

  def show
    respond_with episode
  end
end
