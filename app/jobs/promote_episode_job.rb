# Promote an episode by kicking off its service workers.
class PromoteEpisodeJob < ActiveJob::Base
  queue_as :default

  def perform(model)
    ServiceWorker.perform model
  end
end
