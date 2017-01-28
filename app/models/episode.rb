# frozen_string_literal: true
# A full-length episode of a brother.ly live broadcast. Contains the
# full-length audio and visual recording, as well as a collection of
# performances (with their own recordings) and metadata.
class Episode < ApplicationRecord
  extend FriendlyId

  include SitemapGeneration
  include Media

  has_many :performances
  has_many :artists, through: :performances

  accepts_nested_attributes_for :performances

  scope :latest, -> { order 'starts_at DESC' }
  scope :past, -> { where 'starts_at <= ?', Time.zone.now }
  scope :recent, -> { past.latest }
  scope :future, -> { where 'starts_at >= ?', Time.zone.now }
  scope :upcoming, -> { future.latest }
  scope :in_podcast, -> { where.not audio_file_id: nil }

  friendly_id :number, use: [:finders, :slugged]

  attachment :flyer_file

  after_create :shorten!, unless: :shortened?

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :starts_before_ends

  def self.current
    latest.first
  end

  def future?
    starts_at.present? && starts_at >= Time.current
  end

  def shortened?
    short_link_url.present?
  end

  # Test whether to show a buy ticket link since the event is upcoming.
  def upcoming?
    future? && eventbrite_url.present?
  end

  def started?
    starts_at <= Time.current
  end

  def ended?
    ends_at >= Time.current
  end

  def now?
    started? && !ended?
  end

  # Test whether we are between the start and end times of a given
  # Episode, and whether a Youtube ID is present indicating a live
  # stream is occurring.
  def live?
    now? && youtube_id.present?
  end

  # Test whether a +video_url+ is present and it is past the time at
  # which this episode has started.
  def archived?
    ended? && video_url.present?
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

  def shorten!
    GenerateShortLinkJob.perform_later self
  end

  def starts_before_ends
    return unless ends_at.present? && starts_at.present?
    unless ends_at > starts_at
      errors.add :base, 'cannot start before it ends'
    end
  end
end
