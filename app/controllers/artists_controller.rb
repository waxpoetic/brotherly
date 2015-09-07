class ArtistsController < ApplicationController
  expose :artists, only: [:index]
  expose :artist, only: [:show]
  expose :artists, only: [:select] do
    Artist.search params[:query]
  end

  def index
    respond_with artists
  end

  def show
    respond_with artist
  end
end
