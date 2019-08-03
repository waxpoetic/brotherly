# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriberPresenter do
  let(:subscriber) { Subscriber.new email: 'test@example.com' }
  subject { described_class.new subscriber }

  it 'returns a generic thank you message' do
    expect(subject.thank_you_message).to eq 'Thanks!'
  end

  it 'returns a thank you message including the name' do
    subject.model.name = 'Lester'
    expect(subject.thank_you_message).to eq 'Thanks Lester!'
  end
end
