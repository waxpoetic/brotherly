class UploadYoutubeVideoJob < ActiveJob::Base
  queue_as :uploads

  def perform(model)
    video = Youtube::Video.create(
      name: model.name,
      description: model.description,
      keywords: model.keywords,
      url: Refile.attachment_url(model, :audio_file)
    )
    model.update youtube_id: video.id if video.persisted?
  end
end
