# frozen_string_literal: true
class EpisodesController < ApplicationController
  resource :episode
  collection_actions << :upcoming

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
    @recommendations = present @episode, with: RecommendationsPresenter
    respond_with @episode
  end

  def player
    layout false
  end

  private

  def model
    return super unless params[:id] == '_current'
    present Episode.current
  end
end
