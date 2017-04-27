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

# == Schema Information
#
# Table name: performances
#
#  id                  :integer          not null, primary key
#  artist_id           :integer
#  episode_id          :integer
#  starts_at           :datetime
#  ends_at             :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  audio_file_id       :string
#  audio_transcoded_at :datetime
#  video_url           :string
#  image_id            :string
#  featured            :boolean
#
# Indexes
#
#  index_performances_on_artist_id   (artist_id)
#  index_performances_on_episode_id  (episode_id)
#
# Foreign Keys
#
#  fk_rails_12f4c1c65e  (episode_id => episodes.id)
#  fk_rails_4843d3e300  (artist_id => artists.id)
#
