# frozen_string_literal: true
require 'spec_helper'

module Bitly
  RSpec.describe ShortLink do
    let :url do
      'http://example.com'
    end

    subject do
      ShortLink.new url: url
    end

    let :bitly do
      double 'Bitly::Client'
    end

    let :link do
      double 'Bitly::Link', short_url: 'http://j.mp/abcde'
    end

    before do
      allow(bitly).to receive(:shorten).with(url, history: 1).and_return(link)
      allow(Bitly).to receive(:client).and_return(bitly)
    end

    it 'generates a short link' do
      expect(subject.save).to be true
      expect(subject.send(:link)).to be_present
      expect(subject.send(:link)).to eq(link)
    end

    it 'finds url from short link object' do
      expect(subject.save).to be true
      expect(subject.short_url).to be_present
    end

    it 'validates attributes' do
      expect(subject).to be_valid
    end
  end
end
