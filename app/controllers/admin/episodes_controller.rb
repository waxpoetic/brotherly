class Admin::EpisodesController < Admin::BaseController
  resource :episode, attributes: [
    :name, :description, performance_attributes: [:artist, :file]
  ]

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
    episode.promote unless episode.future?
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
