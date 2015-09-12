require "rails_helper"

RSpec.describe SubscribeToMailchimpWorker, type: :worker do
  let :model do
    double 'Model'
  end

  subject { SubscribeToMailchimpWorker.new model: model }

  it "works" do
    expect(subject.perform).to be true
  end
end
