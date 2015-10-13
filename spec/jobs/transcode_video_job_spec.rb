require 'rails_helper'

RSpec.describe TranscodeVideoJob, type: :job do
  let :episode do
    episodes :four
  end

  before do
    allow(VideoTranscoder).to \
      receive(:perform).with(episode.audio_recording).and_return true
  end

  it "transcodes a video" do
    expect(TranscodeVideoJob.perform_now(episode)).to eq true
  end
end
