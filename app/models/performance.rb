class Performance < ActiveRecord::Base
  include Searchable

  # multisearchable against: [:title]

  belongs_to :artist
  belongs_to :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  attachment :audio_file, extension: 'wav'

  def name
    "#{artist.name} at #{episode.name}"
  end

  alias_method :title, :name
end
