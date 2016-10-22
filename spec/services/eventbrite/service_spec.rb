# frozen_string_literal: true
require 'rails_helper'

module Eventbrite
  RSpec.describe Service, type: :service do
    let :episode do
      episodes :four
    end

    let :event do
      double 'Eventbrite::Event', url: 'http://eventbrite.com/test'
    end

    before do
      allow(Event).to receive(:new).and_return(event)
    end

    subject do
      described_class.new local: episode
    end

    it 'uses the eventbrite api to create an event' do
      expect(subject.class.remote_object).to eq(Event)
    end

    it 'uses a local episode record to power the event' do
      expect(subject.class.local_name).to eq(:episode)
      expect(subject.episode).to eq(subject.local)
    end

    it 'slices out name, starts_at and ends_at' do
      expect(subject.attributes.keys).to include(
        :listed, :capacity, :currency, :venue_id, :format_id,
        :category_id, :subcategory_id, :start, :end
      )
    end

    it 'delegates url to remote record' do
      expect(subject.send(:remote)).to eq(event)
      expect(subject.url).to eq(subject.send(:remote).url)
    end
  end
end
