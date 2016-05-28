class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :eventbrite_url
  has_many :performances
end
