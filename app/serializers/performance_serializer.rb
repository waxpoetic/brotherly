class PerformanceSerializer < ActiveModel::Serializer
  include MediaSerialization

  attributes :id, :name, :starts_at, :ends_at
  has_one :artist
  has_one :episode
end
