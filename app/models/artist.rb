class Artist < ActiveRecord::Base
  include Searchable

  searchable name: 'A'
  multisearchable against: [:name]

  has_many :performances
  has_many :episodes, through: :performances

  validates :name, presence: true

  attachment :image
end
