require 'rails_helper'

RSpec.describe TranscodeAudioJob, type: :job do
  let :episode do
    episodes :four
  end

  before do
    allow(AudioTranscoder).to \
      receive(:perform).with(episode.audio_recording).and_return true
  end

  it "transcodes audio recordings" do
    expect(TranscodeAudioJob.perform_now(episode)).to eq true
  end
end
