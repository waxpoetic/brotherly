require 'rails_helper'

RSpec.describe Event, type: :model do
  let :attributes do
    {
      id: SecureRandom.hex,
      title: 'The Superb Owl',
      description: 'Quite indeed a spectacular bird-of-prey.',
      location: 'Philadelphia, PA',
      starts_at: double(date_time: 1.hour.ago.to_datetime),
      ends_at: double(date_time: Time.current.to_datetime)
    }
  end

  subject :event do
    described_class.new attributes
  end

  describe '.all' do
    it 'collects events from the calendar as event objects' do
      expect(described_class.all).to be_a(Event::Collection)
    end

    xit 'delegates to collection on the class level' do
      collection = double 'Event::Collection', any?: true
      allow(Event).to receive(:all).and_return(collection)
      expect(Event).to be_any
    end
  end

  describe '.recent' do
    xit 'finds events in the last hour' do
      collection = double 'Event::Collection', since: []
      allow(described_class).to receive(:all).and_return(collection)
      expect(described_class.recent).to be_any
    end
  end

  describe '.from_calendar' do
    it 'creates a new Event in memory from GCal data' do
      item = double(
        id: '12345',
        summary: 'test',
        description: 'test',
        location: 'test',
        start: double(date: 1.day.ago.to_date, date_time: nil),
        end: double(date: Date.today, date_time: nil)
      )
      expect(described_class.from_calendar(item)).to be_valid
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

  describe '#all_day?' do
    it 'is true when starts_at is a Date' do
      allow(event).to receive(:starts_at).and_return(1.day.ago.to_date)
      expect(event).to be_all_day
    end

    it 'is false when starts_at is a DateTime' do
      allow(event).to receive(:starts_at).and_return(1.hour.ago.to_datetime)
      expect(event).not_to be_all_day
    end
  end

  describe '#time' do
    it 'returns human-readable timestamp of event' do
      expect(event.time).to include('from')
      expect(event.time).to include('to')
    end

    it 'returns "all day" when all day' do
      allow(event).to receive(:starts_at).and_return(1.day.ago.to_date)
      allow(event).to receive(:ends_at).and_return(1.day.ago.to_date)
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
