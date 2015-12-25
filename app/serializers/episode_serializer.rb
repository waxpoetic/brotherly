class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :eventbrite_url, :youtube_id, :mixcloud_url
end
