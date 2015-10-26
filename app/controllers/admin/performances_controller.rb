class Admin::PerformancesController < AdminController
  resource :performance do
    permit :artist_id, :episode_id, :starts_at, :ends_at, :youtube_url
  end
end
