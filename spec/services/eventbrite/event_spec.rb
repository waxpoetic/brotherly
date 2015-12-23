require 'rails_helper'

module Eventbrite
  RSpec.describe Event do
    subject do
      described_class.new id: '12345', name: 'test'
    end

    it 'creates event on eventbrite' do
      expect(subject.save).to be true
    end

    it 'is saved when id is present' do
      expect(subject).to be_persisted
    end

    it 'converts event response data into a hash' do
      expect(subject.to_h).to include('id')
    end
  end
end
