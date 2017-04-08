class PerformanceSerializer < ActiveModel::Serializer
  attributes :id, :artist_id, :episode_id, :starts_at, :ends_at,
             :audio_file_url, :video_url, :image_url, :featured
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
