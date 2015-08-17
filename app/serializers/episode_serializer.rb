class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :eventbrite_url, :youtube_url, :mixcloud_url
end
