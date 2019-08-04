# frozen_string_literal: true

class Artist < ApplicationRecord
  extend FriendlyId

  include SitemapGeneration

  friendly_id :name

  has_many :performances, dependent: :destroy
  has_many :episodes, through: :performances

  validates :name, presence: true

  has_one_attached :image_file
end
