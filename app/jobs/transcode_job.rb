class TranscodeJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    jobs.each { |job| job.perform_later episode }
  end

  private

  def jobs
    [ TranscodeVideoJob, TranscodeAudioJob ]
  end
end
