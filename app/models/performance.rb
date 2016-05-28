class Performance < ActiveRecord::Base
  include Searchable
  include Media

  multisearchable against: [:name]

  belongs_to :artist
  belongs_to :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  before_save :ensure_name

  scope :play_order, -> { order 'starts_at DESC' }

  private

  def ensure_name
    self.name ||= "#{artist.name} at #{episode.name}"
  end
end
