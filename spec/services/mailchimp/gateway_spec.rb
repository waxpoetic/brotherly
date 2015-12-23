require 'rails_helper'

module Mailchimp
  RSpec.describe Gateway, type: :gateway do
    subject { described_class.new }

    let :params do
      {
        email: 'test@example.com'
      }
    end

    let :response do
      subject.create_member(params)
    end

    it 'finds the configured list on mailchimp' do
      expect(subject.list).to be_a(APIRequest)
    end

    it 'creates a new member on the list' do
      expect(response).to be_success
    end
  end
end
