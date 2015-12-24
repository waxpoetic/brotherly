require 'rails_helper'

RSpec.describe Episode, type: :model do
  subject do
    Episode.new name: 'brother.ly zero', eventbrite_event_id: '1'
  end

  let :event do
    double 'Eventbrite::Event'
  end

  it 'can be in the future' do
    subject.starts_at = 1.hour.from_now
    expect(subject).to be_future
  end

  it 'can be published' do
    subject.published_at = 1.hour.ago
    expect(subject).to be_published
  end

  it 'has an event' do
    allow(Eventbrite::Event).to \
      receive(:find).with(subject.eventbrite_event_id).and_return(event)
    expect(subject.event).to eq event
  end

  it 'has a number' do
    expect(subject.number).to eq 'zero'
  end
end
