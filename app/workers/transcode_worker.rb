require 'aws/elastic_transcoder'

# Base worker class for AWS Elastic Transcoder operations. All this
# worker does is create a job on the Elastic Transcoder side to enqueue
# the provided file path for transcode.
class TranscodeWorker < Brotherly::Worker
  delegate :path, :extension, to: :model

  alias_method :recording, :model
  alias_method :original_path, :path

  # Transcode a given media file to HLS.
  def perform
    transcoder.create_job(
      pipeline_id: pipeline_id,
      input: { key: original_path },
      output: { key: transcode_path }
    )
  end

  private

  def pipeline_id
    raise NotImplementedError
  end

  def new_extension
    raise NotImplementedError
  end

  def transcode_path
    path.gsub extension, new_extension
  end

  def transcoder
    @transcoder ||= AWS::ElasticTranscoder::Client.new(
      region: secrets.aws_region,
      credentials: {
        aws_access_key_id: secrets.aws_access_key_id,
        aws_secret_access_key: secrets.aws_secret_access_key
      }
    )
  end

  def secrets
    Rails.application.secrets
  end
end
