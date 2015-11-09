class Performance < ActiveRecord::Base
  include Searchable

  multisearchable against: [:title]

  belongs_to :artist
  belongs_to :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  def name
    "#{artist.name} at #{episode.name}"
  end
end
