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
  scope :past, -> { where 'starts_at <= ?', Time.zone.now }
  scope :recent, -> { past.latest }
  scope :future, -> { where 'starts_at >= ?', Time.zone.now }
  scope :upcoming, -> { future.latest }
  scope :in_podcast, -> { where.not audio_file_id: nil }

  friendly_id :number

  searchable :name
  multisearchable against: [:name]

  attachment :flyer_file
  attachment :audio_file, extension: 'mp3'

  # after_create :transcode!, if: :has_audio?
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

  def event
    Eventbrite::Event.find eventbrite_event_id
  end

  def number
    name.gsub(/brother\.ly\s/, '')
  end

  private

  def generate_short_url
    GenerateEpisodeLink.perform_later self
  end
end
