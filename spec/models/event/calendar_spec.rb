require 'rails_helper'

class Event
  RSpec.describe Calendar, type: :model do
    subject :calendar do
      described_class.new
    end

    it 'authorizes the event calendar' do
      VCR.use_cassette :google_calendar_authorize_url do
        expect { calendar.authorize_url }.not_to raise_error
      end
    end
  end
end
