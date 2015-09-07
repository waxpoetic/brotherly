class ArtistsController < ApplicationController
  expose :artists, only: [:index]
  expose :artist, only: [:show]

  def index
    respond_with artists
  end

  def show
    respond_with artist
  end
end
