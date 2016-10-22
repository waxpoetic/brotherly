# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Artist, type: :model do
  subject do
    Artist.new name: 'test'
  end

  it 'represents an artist who played the event' do
    expect(subject).to be_valid
  end

  it 'regenerates sitemap when saved' do
    expect(subject.save).to be true
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs).to include(
      job: GenerateSitemapJob,
      args: [],
      queue: 'default'
    )
  end
end
