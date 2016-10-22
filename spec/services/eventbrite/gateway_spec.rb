# frozen_string_literal: true
module Eventbrite
  RSpec.describe Gateway do
    let :event do
      Event.new 'name' => 'test'
    end

    before do
      allow(subject).to receive(:post_event).and_return(
        double(id: '12345', name: 'test')
      )
      allow(subject).to receive(:publish_event).with('12345').and_return(
        success: true
      )
    end

    it 'creates a new event' do
      expect(subject.create_event(event)).to be_success
    end
  end
end
