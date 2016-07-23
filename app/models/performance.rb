class Performance < ApplicationRecord
  include Searchable
  include Media

  # multisearchable against: [:title]

  belongs_to :artist
  belongs_to :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  attachment :audio_file, extension: 'wav'

  scope :play_order, -> { order 'starts_at DESC' }

  def name
    "#{artist.name} at #{episode.name}"
  end

  alias title name
end
