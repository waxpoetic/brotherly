# frozen_string_literal: true
require 'rails_helper'

module Mailchimp
  RSpec.describe Response do
    subject { described_class.new request: { 'id' => 1, 'foo' => 'bar' } }

    it 'delegates attrs to the request' do
      expect(subject['foo']).to eq 'bar'
      expect(subject.foo).to eq 'bar'
    end

    it 'is successful when id is present' do
      expect(subject).to be_success
    end
  end
end
