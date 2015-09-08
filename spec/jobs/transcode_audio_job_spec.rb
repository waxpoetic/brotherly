require 'rails_helper'

RSpec.describe TranscodeAudioJob, type: :job do
  let :episode do
    episodes :four
  end

  before do
    allow(TranscodeAudioWorker).to \
      receive(:perform).with(episode.audio_recording).and_rturn true
  end

  it "transcodes audio recordings" do
    expect(subject.perform_now(episode)).to eq true
  end
end
