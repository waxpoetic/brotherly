# frozen_string_literal: true
class Artist < ApplicationRecord
  extend FriendlyId

  include SitemapGeneration

  friendly_id :name

  has_many :performances
  has_many :episodes, through: :performances

  validates :name, presence: true

  attachment :image_file
end

# == Schema Information
#
# Table name: artists
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  slug          :string
#  links         :hstore
#  description   :text
#  image_file_id :string
#
