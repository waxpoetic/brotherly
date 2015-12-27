class Performance < ActiveRecord::Base
  extend FriendlyId

  include Searchable
  include AudioFile

  multisearchable against: [:name]
  searchable :name

  belongs_to :artist
  belongs_to :episode

  before_validation :generate_name

  validates :artist,    presence: true
  validates :episode,   presence: true
  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  attachment :audio_file, extension: 'mp3'

  alias_attribute :title, :name

  scope :play_order, -> { order 'starts_at DESC' }

  friendly_id :artist_name

  private

  # @private
  def generate_name
    return unless artist.present? && episode.present?
    self.name = "#{artist.name} at #{episode.name}"
  end

  # Used as the slug for friendly_id, generating urls such as
  # +/episodes/one/performances/the-wonder-bars+.
  #
  # @private
  # @return [String]
  def artist_name
    artist.name
  end
end
