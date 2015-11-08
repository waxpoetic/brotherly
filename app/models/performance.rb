class Performance < ActiveRecord::Base
  include Recordable
  include Searchable

  belongs_to :artist
  belongs_to :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true
end
