class Performance < ActiveRecord::Base
  include Searchable

  belongs_to :artist
  belongs_to :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true
end
