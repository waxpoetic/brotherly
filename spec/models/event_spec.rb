require 'rails_helper'

RSpec.describe Event, type: :model do
  let :attributes do
    {
      id: SecureRandom.hex,
      title: 'The Superb Owl',
      description: 'Quite indeed a spectacular bird-of-prey.',
      location: 'Philadelphia, PA',
      starts_at: 1.hour.ago.to_datetime,
      ends_at: Time.current.to_datetime,
      all_day: false
    }
  end

  subject :event do
    described_class.new attributes
  end

  describe '.calendar' do
    it 'returns a Google::Calendar object representing the calendar' do
      expect(described_class.calendar).to be_a(Google::Calendar)
    end
  end

  describe '.all' do
    it 'collects events from the calendar as event objects' do
      expect(described_class.all).to be_a(Event::Collection)
    end

    it 'delegates to collection on the class level' do
      expect(described_class.all).to be_any
      expect(described_class).to be_any
    end
  end

  describe '#all_day?' do
    it 'is true when all_day is set to true' do
      expect(event).to be_all_day
    end

    it 'returns false when all_day is set to false' do
      event.all_day = false
      expect(event).not_to be_all_day
    end

    it 'returns false when all_day is set to nil' do
      event.all_day = nil
      expect(event).not_to be_all_day
    end
  end

  describe '#persisted?' do
    it 'is true when id is present' do
      event.id = '12345'
      expect(event).to be_persisted
    end

    it 'is false when id is missing' do
      event.id = nil
      expect(event).not_to be_persisted
    end
  end

  describe '#time' do
    it 'returns human-readable timestamp of event' do
      expect(event.time).to include('from')
      expect(event.time).to include('to')
    end

    it 'returns "all day" when all day' do
      event.all_day = true
      expect(event.time).to include('all day')
    end
  end

  describe '#attributes' do
    it 'delegates key lookup' do
      expect(event).to include(:id)
    end

    it 'delegates key retrieval' do
      expect(event[:id]).to eq(event.attributes[:id])
    end

    it 'is accessed indifferently' do
      expect(event.attributes[:id]).to eq(event.attributes['id'])
    end

    it 'returns json representation' do
      expect(event.to_json).to eq(event.attributes.to_json)
    end
  end
end
