require 'rails_helper'

RSpec.describe PerformancePresenter do
  let :performance do
    performances :del_at_four
  end

  subject { described_class.new performance }

  it 'returns the cover image for this performance' do
    expect(subject.cover_image).to include('placehold.it')
  end

  it 'returns the audio file url for this performance' do
    expect(subject.audio).not_to be_present
  end

  it 'tests whether the performance can be downloaded' do
    expect(subject).not_to be_downloadable
  end
  it 'delegates performance name to artist' do
    expect(subject.artist_name).to eq(performance.artist.name)
  end
end
