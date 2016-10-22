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
