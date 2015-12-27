module AudioFile
  extend ActiveSupport::Concern

  included do
    attachment :audio_file, extension: 'mp3'

    after_create :upload_to_mixcloud!, if: :audio?
  end

  def audio?
    audio_file.present?
  end

  protected

  def upload_to_mixcloud!
    MixcloudUploadJob.perform_later self
  end
end
