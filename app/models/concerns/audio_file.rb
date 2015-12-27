module AudioFile
  extend ActiveSupport::Concern

  included do
    attachment :audio_file, extension: 'mp3'

    after_create :upload_to_mixcloud!, if: :audio?
  end

  def audio?
    audio_file.present?
  end

  def mixcloud_url
    "http://mixcloud.com/#{cloudcast_key}"
  end

  protected

  def upload_to_mixcloud!
    MixcloudUploadJob.perform_later self
  end
end
