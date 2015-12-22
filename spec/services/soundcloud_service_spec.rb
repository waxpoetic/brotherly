require 'rails_helper'

RSpec.describe SoundcloudService, type: :service do
  let :episode do
    episodes :test
  end

  let :remote do
    double 'SoundCloud::Track'
  end

  subject do
    described_class.new local: episode
  end

  before do
    allow(SoundCloud::Track).to receive(:new).and_return(remote)
  end

  it 'defines attributes to copy to remote' do
    expect(subject.attributes.keys).to include(:title)
    expect(subject.attributes.keys).to include(:asset_data)
    expect(subject.attributes[:title]).to eq(episode.name)
    expect(subject.attributes[:asset_data]).to eq(episode.audio_file)
  end

  it 'creates and saves remote object' do
    expect(subject.save).to be true
  end
end
