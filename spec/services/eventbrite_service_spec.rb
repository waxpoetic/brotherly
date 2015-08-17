require 'rails_helper'

RSpec.describe EventbriteService, type: :service do
  let :episode do
    episodes :one
  end

  subject do
    EventbriteService.new local: episode
  end

  it 'uses the eventbrite api to create an event' do
    expect(subject.class.remote_object).to eq(Eventbrite::Event)
  end

  it 'uses a local episode record to power the event' do
    expect(subject.class.local_name).to eq(:episode)
    expect(subject.episode).to eq(subject.remote)
  end

  it 'slices out name, starts_at and ends_at' do
    expect(subject.attributes.keys).to include(:name, :starts_at, :ends_at)
  end

  it 'delegates url to remote record' do
    expect(subject.url).to eq(subject.remote.url)
  end
end
