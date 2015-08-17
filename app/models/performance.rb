class Performance < ActiveRecord::Base
  include Recordable

  belongs_to :artist
  belongs_to :episode

  delegate :name, to: :artist

  friendly_id :name

  validates :starts_at, presence: true
  validates :ends_at,   presence: true
end
