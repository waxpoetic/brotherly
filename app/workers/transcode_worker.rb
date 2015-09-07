# Initiates all other transcode jobs.
class TranscodeWorker < Brotherly::Worker
  def perform
    jobs.each { |job| job.perform_later episode }
  end

  private

  def jobs
    [ TranscodeVideoJob, TranscodeAudioJob ]
  end
end
