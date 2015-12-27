class MixcloudUploadJob < ActiveJob::Base
  queue_as :uploads

  def perform(model)
    cloudcast = Mixcloud::Upload.create(
      name: model.name,
      mp3: model.audio_file.contents,
      picture: model.flyer_file.contents,
      description: model.description
    )
    model.update cloudcast_key: cloudcast.key if upload.persisted?
  end
end
