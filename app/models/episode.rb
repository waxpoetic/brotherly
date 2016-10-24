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

  after_create :shorten!, unless: :short_url?

  def self.current
    latest.first
  end

  def future?
    return true if starts_at.blank?
    starts_at >= Time.current
  end

  def streaming?
    youtube_id.present?
  end

  def past?
    !future?
  end

  def archived?
    video_file_id.present?
  end

  def published?
    published_at.present?
  end

  def transcoded?
    video_transcoded_at.present?
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
end
