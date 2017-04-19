require 'rails_helper'

RSpec.describe DownloadEventsJob, type: :job do
  it 'creates new event records from google calendar' do
    event = { title: 'foo', starts_at: 'bar', ends_at: 'baz', description: 'wut' }
    calendar = [ event ]
    allow(Event).to receive(:calendar).and_return(calendar)
    expect { described_class.perform_now }.to change(Event, :count).by(1)
  end
end
