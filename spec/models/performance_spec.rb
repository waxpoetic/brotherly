# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Performance, type: :model do
  let :artist do
    Artist.new name: 'Artist'
  end

  let :episode do
    Episode.new name: 'Episode'
  end

  subject do
    Performance.new(
      artist: artist,
      episode: episode,
      starts_at: 1.hour.from_now,
      ends_at: 2.hours.from_now
    )
  end

  it 'renders the name' do
    expect(subject.name).to eq('Artist at Episode')
  end

  it 'attaches an audio file' do
    expect(subject).to respond_to :audio_file
  end
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
