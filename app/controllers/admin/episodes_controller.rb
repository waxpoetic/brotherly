class Admin::EpisodesController < AdminController
  resource :episode do
    permit :name, :description, performance_attributes: [:artist]
  end

  def create
    episode.save
    episode.promote unless episode.future?
    respond_with episode
  end
end
