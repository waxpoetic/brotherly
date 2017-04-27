# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  subject do
    Subscriber.new name: 'test', email: 'test@example.com'
  end

  it 'requires a valid email' do
    expect(subject).to be_valid
    subject.email = 'test'
    expect(subject).not_to be_valid
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'subscribes the user to mailchimp' do
    expect(subject.save).to eq true
    expect(subject.send(:add!)).to be_a(AddSubscriberJob)
  end
end

# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
