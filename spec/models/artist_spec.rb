require 'rails_helper'

RSpec.describe Artist, type: :model do
  subject do
    Artist.new name: 'test'
  end

  it 'represents an artist who played the event' do
    expect(subject).to be_valid
  end
end
