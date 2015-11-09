# "Promotes" an episode by firing off its service workers, which either
# post about or create the episode on our various social media and event
# support networks.
class PromoteEpisodeJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    Brotherly::Service.each do |service|
      episode.update service.create(episode).to_h
    end
  end
end
