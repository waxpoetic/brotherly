# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationPresenter, type: :presenter do
  let(:artist) { artists :del }
  subject { described_class.new artist }

  it 'returns the title' do
    expect(subject.title).to eq artist.name.titleize
  end

  it 'returns the placeholder text' do
    expect(subject.placeholder_text).to eq artist.name
  end

  it 'inherently translates keys' do
    expect(subject.t(:title)).to eq t(:title)
  end
end
