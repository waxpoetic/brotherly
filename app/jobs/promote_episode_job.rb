# "Promotes" an episode by firing off its promoter workers, which either
# post about or create the episode on our various social media and event
# support networks.
class PromoteEpisodeJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    episode.update Brotherly.promoters.reduce({}) do |attributes, promoter|
      attributes.merge promoter.promote(episode)
    end
  end
end
