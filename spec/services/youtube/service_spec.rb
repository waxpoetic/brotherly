require 'rails_helper'

RSpec.describe YoutubeService, type: :service do
  let :episode do
    episodes :four
  end

  let :video do
    double 'Youtube::Video', url: 'http://youtube.com/video'
  end

  subject do
    YoutubeService.new local: episode
  end

  before do
    allow(Youtube::Video).to receive(:new).and_return(video)
  end

  it 'uses a Youtube::Video object as a remote' do
    expect(subject.class.remote_object).to eq(Youtube::Video)
  end

  it 'slices name, starts_at and ends_at from attrs' do
    expect(subject.attributes.keys).to include(:category, :keywords, :title)
  end

  it 'delegates url to video class' do
    expect(subject.send(:remote)).to be_present
    expect(subject.url).to eq(subject.send(:remote).url)
  end
end
