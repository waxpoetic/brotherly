class Admin::ArtistsController < Admin::BaseController
  resource :artist, attributes: [ :name ]

  def index
    respond_with artists
  end

  def show
    respond_with artist
  end

  def create
    artist.save
    respond_with artist
  end

  def update
    artist.update edit_params
    respond_with artist
  end

  def destroy
    artist.destroy
    respond_with artist
  end
end
