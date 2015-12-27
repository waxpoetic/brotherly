require 'rails_helper'

RSpec.describe SearchDecorator do
  let :search do
    double(
      'Search',
      query: 'test',
      results: [Subscriber.new(email: 'test@example.com')]
    )
  end

  subject { described_class.new search }

  it 'decorates results' do
    expect(subject.results).not_to be_empty
    expect(subject.results.first).to be_a SearchResultDecorator
  end
end
