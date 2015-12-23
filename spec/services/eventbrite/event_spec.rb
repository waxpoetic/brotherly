require 'rails_helper'

module Eventbrite
  RSpec.describe Event do
    subject do
      described_class.new(
        id: '12345',
        attributes: {
        }
      )
    end

    it 'creates event on eventbrite'
    it 'is saved when id is present'
    it 'creates ticket classes for event'
    it 'publishes event to eventbrite'
    it 'converts event response data into a hash'
  end
end
