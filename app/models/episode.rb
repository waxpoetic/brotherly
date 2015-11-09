# A full-length episode of a brother.ly live broadcast. Contains the
# full-length audio and visual recording, as well as a collection of
# performances (with their own recordings) and metadata.
class Episode < ActiveRecord::Base
  extend FriendlyId

  include Searchable

  has_many :performances
  has_many :artists, through: :performances

  accepts_nested_attributes_for :performances

  scope :latest, -> { order 'starts_at DESC' }
  scope :recent, -> { latest.where "starts_at <= ?", Time.now }
  scope :upcoming, -> { latest.where "starts_at >= ?", Time.now }

  friendly_id :name

  searchable name: 'A'
  multisearchable against: [:name]

  attachment :flyer_file
  attachment :audio_file, extension: 'wav'

  after_create :transcode!
  after_create :promote!, if: :future?

  def self.current
    latest.first
  end

  def future?
    starts_at >= Time.current
  end

  def published?
    published_at.present?
  end

  def promote
    PromoteEpisodeJob.perform_later self
  end

  def event
    Eventbrite::Event.find eventbrite_event_id
  end

  private

  def generate_short_url
    GenerateEpisodeLink.perform_later self
  end
end
