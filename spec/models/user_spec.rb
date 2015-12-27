require 'rails_helper'

RSpec.describe User, type: :model do
  subject { users :admin }

  it 'sends notifications with activejob' do
    expect(
      subject.send_devise_notification(:password_change, user: subject)
    ).to be_a(ActiveJob::Base)
  end

  it 'can be searched' do
    expect(User.search(subject.name)).to include(subject)
  end
end
