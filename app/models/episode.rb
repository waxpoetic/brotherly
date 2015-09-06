# A full-length episode of a brother.ly live broadcast. Contains the
# full-length audio and visual recording, as well as a collection of
# performances (with their own recordings) and metadata.
class Episode < ActiveRecord::Base
  extend FriendlyId

  include Recordable
  include Searchable

  has_many :performances
  has_many :artists, through: :performances

  accepts_nested_attributes_for :performances

  scope :latest, -> { order :starts_at }

  friendly_id :name

  searchable name: 'A'
  multisearchable against: [:name]

  def future?
    starts_at >= Time.current
  end

  def published?
    published_at.present?
  end

  def promote
    PromoteEpisodeJob.perform_later self
  end

  private

  def generate_short_url
    GenerateEpisodeLink.perform_later self
  end
end
