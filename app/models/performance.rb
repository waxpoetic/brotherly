class Performance < ActiveRecord::Base
  extend FriendlyId

  include Recordable
  include Searchable

  belongs_to :artist
  belongs_to :episode

  delegate :name, to: :artist

  friendly_id :name

  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  multisearchable against: [:name]
end
