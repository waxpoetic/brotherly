class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :audio_file

  def video_url
    "http://www.youtube.com/?v=#{object.youtube_id}"
  end

  def embed_url
    "http://www.youtube.com/embed/#{object.youtube_id}"
  end

  def event_url
    object.event.url
  end
end
