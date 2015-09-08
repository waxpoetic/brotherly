require 'spec_helper'
require 'short_link'

RSpec.describe ShortLink do
  fixtures :episodes

  let :episode do
    episodes :four
  end

  subject { ShortLink.new episode }

  it 'uses an episode for the full url' do
    expect(subject.episode).to eq(episode)
  end

  it 'generates a short link' do
    expect(subject.link).to be_present
  end

  it 'finds url from short link object' do
    expect(subject.url).to be_present
  end
end
