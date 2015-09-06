class ArtistsController < ApplicationController
  expose :artists, only: [:index]
  expose :aritst, only: [:show]

  def index
    respond_with artists
  end

  def show
    respond_with artist
  end
end
