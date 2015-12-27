class Performance < ActiveRecord::Base
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

  attachment :audio_file, extension: 'wav'

  alias_attribute :title, :name

  scope :play_order, -> { order 'starts_at DESC' }

  private

  def generate_name
    self.name = "#{artist.name} at #{episode.name}" if artist && episode
  end
end
