# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AddSubscriberJob, type: :job do
  let :subscriber do
    Subscriber.new name: 'test', email: 'test@example.com'
  end

  it 'creates a subscriber on mailchimp' do
    expect(subject.perform(subscriber)).to be_a Mailchimp::Subscriber
  end
end
