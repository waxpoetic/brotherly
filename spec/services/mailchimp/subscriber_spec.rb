# frozen_string_literal: true
module Mailchimp
  RSpec.describe Subscriber do
    let :described_class do
      Mailchimp::Subscriber
    end

    let :email do
      'lester.tester@example.com'
    end

    let :name do
      'Lester Tester'
    end

    let :list do
      SecureRandom.hex 16
    end

    subject do
      described_class.new email: email, name: name
    end

    it 'validates given attributes' do
      expect(subject).to be_valid
      subject.email = nil
      expect(subject).not_to be_valid
    end

    context 'when the mailchimp gateway accepts the request' do
      before do
        allow(Mailchimp::Gateway.for_env).to receive(:create_member).and_return(
          Response.new(request: { 'id' => SecureRandom.hex })
        )
      end

      it 'creates user on the mailchimp list' do
        expect(subject.save).to be true
        expect(subject).to be_persisted
      end

      it 'is created in memory and persisted' do
        subscriber = described_class.create(email: email, name: name)
        expect(subscriber).to be_a(Subscriber)
        expect(subscriber).to be_persisted
      end
    end

    context 'when the mailchimp gateway denies the request' do
      before do
        allow(Mailchimp::Gateway.for_env).to receive(:create_member).and_return(
          Response.new
        )
      end

      it 'fails to create user on the mailchimp list' do
        expect(subject.save).to be false
        expect(subject).not_to be_persisted
      end

      it 'is created in memory but not persisted' do
        subscriber = described_class.create(email: email, name: name)
        expect(subscriber).to be_a(Subscriber)
        expect(subscriber).not_to be_persisted
      end
    end
  end
end
