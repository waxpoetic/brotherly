# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Episode, type: :model do
  subject do
    Episode.new(
      name: 'brother.ly zero',
      eventbrite_event_id: '1',
      published_at: Time.current,
      starts_at: Time.current,
      ends_at: 1.minute.from_now
    )
  end

  it 'can be in the future' do
    expect(subject).not_to be_future
    subject.starts_at = 1.hour.from_now
    expect(subject).to be_future
  end

  it 'is upcoming when in the future and event link posted' do
    allow(subject).to receive(:future?).and_return(true)
    subject.eventbrite_url = 'http://example.com'
    expect(subject).to be_upcoming
  end

  it 'has started when starts_at has past' do
    subject.starts_at = 1.hour.ago
    expect(subject).to be_started
  end

  it 'has ended when ends_at has past' do
    subject.ends_at = 1.hour.ago
    expect(subject).to be_ended
  end

  it 'is currently happening when started and not ended' do
    allow(subject).to receive(:started?).and_return(true)
    allow(subject).to receive(:ended?).and_return(false)
    expect(subject).to be_now
  end

  it 'is live when youtube video has been created' do
    expect(subject).not_to be_live
    allow(subject).to receive(:started?).and_return(true)
    allow(subject).to receive(:ended?).and_return(false)
    subject.youtube_id = 'X1vB5'
    expect(subject).to be_live
  end

  it 'is archived when video_url has been set and past ends_at time' do
    expect(subject).not_to be_archived
    allow(subject).to receive(:ended?).and_return(true)
    subject.video_url = 'http://example.com/video.m3u8'
    expect(subject).to be_archived
  end

  it 'is shortened when short link url present' do
    expect(subject).not_to be_shortened
    subject.short_link_url = 'http://bit.ly/brotherly-0'
    expect(subject).to be_shortened
  end

  it 'has a number' do
    expect(subject.number).to eq 'zero'
  end

  it 'regenerates sitemap when saved' do
    expect(subject.save).to be(true), subject.errors.full_messages.to_sentence
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs).to include(
      job: GenerateSitemapJob,
      args: [],
      queue: 'default'
    )
  end

  it 'derives playlist name from episode name' do
    expect(subject.playlist_name).to eq('brother-ly-zero')
  end
end
