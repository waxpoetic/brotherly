require 'rails_helper'

module Eventbrite
  RSpec.describe Event do
    let :id do
      '12345'
    end

    let :name do
      'test'
    end

    let :gateway do
      double(
        create_event: double(success?: true, id: id),
        event_get: double(success?: true, event: { foo: 'bar' })
      )
    end

    subject do
      described_class.new id: id, name: name
    end

    it 'creates event on eventbrite' do
      expect(subject.save).to be true
    end

    it 'is saved when id is present' do
      allow(subject).to receive(:data).and_return(foo: 'bar')
      expect(subject).to be_persisted
    end

    it 'converts event response data into a hash' do
      expect(subject.to_h).to include(:eventbrite_event_id)
    end

    it 'can be found' do
      expect(described_class.find(id)).to be_present
    end

    it 'can be created' do
      event = described_class.create(name: name)
      expect(event.id).to be_present
      expect(event).to be_persisted
    end
  end
end
