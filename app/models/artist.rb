class Artist < ApplicationRecord
  extend FriendlyId

  include SitemapGeneration

  searchable :name
  multisearchable against: [:name]

  friendly_id :name

  has_many :performances
  has_many :episodes, through: :performances

  validates :name, presence: true

  attachment :image_file
end
