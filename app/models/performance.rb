# frozen_string_literal: true
class Performance < ApplicationRecord
  include Media

  belongs_to :artist
  belongs_to :episode

  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  scope :play_order, -> { order 'starts_at DESC' }
  scope :featured, -> { where featured: true }

  attachment :image

  def name
    "#{artist.name} at #{episode.name}"
  end

  alias title name
end
