class Performance < ActiveRecord::Base
  belongs_to :artist
  belongs_to :episode

  delegate :name, to: :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true
end
