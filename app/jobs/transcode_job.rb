class TranscodeJob < ActiveJob::Base
  queue_as :transcodes

  def perform(episode)
    TranscodeWorker.perform episode
  end
end
