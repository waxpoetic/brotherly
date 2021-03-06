# frozen_string_literal: true

# A full-length episode of a brother.ly live broadcast. Contains the
# full-length audio and visual recording, as well as a collection of
# performances (with their own recordings) and metadata.
class Episode < ApplicationRecord
  extend FriendlyId

  include SitemapGeneration
  include Media

  has_many :performances, dependent: :destroy
  has_many :artists, through: :performances

  accepts_nested_attributes_for :performances

  scope :latest, -> { order 'starts_at DESC' }
  scope :past, -> { where 'starts_at <= ?', Time.zone.now }
  scope :recent, -> { past.latest }
  scope :future, -> { where 'starts_at >= ?', Time.zone.now }
  scope :upcoming, -> { future.latest }
  scope :current, lambda {
    where 'starts_at <= ? AND ends_at >= ?', Time.zone.now, Time.zone.now
  }
  scope :in_podcast, -> { where.not audio_file_id: nil }
  scope :featured, -> { where featured: true }

  friendly_id :number, use: %i[finders slugged]

  attachment :flyer_file

  after_create :shorten!, unless: :shortened?

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validate :starts_before_ends

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
    starts_at.present? && starts_at <= Time.current
  end

  def ended?
    ends_at.present? && ends_at <= Time.current
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

  def number
    name.gsub(/brother\.ly\s/, '')
  end

  private

  def shorten!
    GenerateShortLinkJob.perform_later self
  end

  def starts_before_ends
    return unless ends_at.present? && starts_at.present?

    errors.add :base, 'cannot start before it ends' unless ends_at > starts_at
  end
end
