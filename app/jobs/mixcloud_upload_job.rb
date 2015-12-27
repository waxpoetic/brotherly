class MixcloudUploadJob < ActiveJob::Base
  queue_as :uploads

  def perform(model)
    upload = Mixcloud::Upload.create(
      name: model.name,
      mp3: model.audio_file.contents,
      picture: model.flyer_file.contents,
      description: model.description
    )
    model.update mixcloud_id: upload.id if upload.persisted?
  end
end
