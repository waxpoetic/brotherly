class TranscodeJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    TranscodeWorker.perform episode
  end
end
