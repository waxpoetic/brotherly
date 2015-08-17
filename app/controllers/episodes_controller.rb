class EpisodesController < ApplicationController
  resource :episode, order: :starts_at do
    collection :index, :next
  end

  def next
    respond_with episodes.first
  end

  def index
    respond_with episodes
  end

  def show
    respond_with episode
  end
end
