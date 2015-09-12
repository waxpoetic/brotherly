require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  subject do
    Subscriber.new name: 'test', email: 'test@example.com'
  end

  it "requires a valid email" do
    expect(subject).to be_valid
    subject.email = 'test'
    expect(subject).not_to be_valid
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it "subscribes the user to mailchimp" do
    expect(subject.save).to eq true
    allow(SubscribeToMailchimpWorker).to \
      receive(:perform).with(subject).and_return(true)
    expect(subject.subscribe).to be_a(SubscribeToMailchimpJob)
  end
end
