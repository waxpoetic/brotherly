class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :eventbrite_url

  def video_url
    "http://www.youtube.com/?v=#{object.youtube_id}"
  end
end
