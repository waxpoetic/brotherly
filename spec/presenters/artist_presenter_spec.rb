# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ArtistPresenter do
  let :artist do
    artists :rnd
  end

  subject do
    described_class.new artist
  end

  it 'returns the title of this artist' do
    expect(subject.title).to eq artist.name
  end

  it 'returns this artist image or a fallback' do
    expect(subject.image).to include('placehold.it')
  end
end
