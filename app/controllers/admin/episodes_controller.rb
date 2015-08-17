class Admin::EpisodesController < Admin::BaseController
  resource :episode do
    modify :name, :artists_attributes, :performances_attributes
    search :name
  end

  def index
    respond_with episodes
  end

  def show
    respond_with episode
  end

  def new
    render 'new'
  end

  def create
    episode.save
    respond_with episode
  end

  def update
    episode.update(edit_params)
    respond_with episode
  end

  def destroy
    episode.destroy
    respond_with episode
  end
end
