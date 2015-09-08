require 'rails_helper'

RSpec.describe YoutubeService, type: :service do
  let :episode do
    episodes :four
  end

  subject do
    YoutubeService.new local: episode
  end

  it 'uses a Youtube::Video object as a remote' do
    expect(subject.class.remote_object).to eq(Youtube::Video)
  end

  it 'slices name, starts_at and ends_at from attrs' do
    expect(subject.attributes.keys).to include(:name, :starts_at, :ends_at)
  end

  it 'delegates url to video class' do
    expect(subject.url).to eq(subject.remote.url)
  end
end
