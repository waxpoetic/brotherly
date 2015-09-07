# Promote an episode by kicking off its service workers.
class PromoteEpisodeJob < ActiveJob::Base
  queue_as :promotions

  def perform(model)
    ServiceWorker.perform model
  end
end
