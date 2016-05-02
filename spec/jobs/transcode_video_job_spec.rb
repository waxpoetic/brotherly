require 'rails_helper'

RSpec.describe TranscodeVideoJob, type: :job do
  let :episode do
    episodes :three
  end

  subject do
    described_class.new
  end

  it 'starts a transcode for video' do
    expect(subject.perform(episode)).to be true
    expect { episode.reload }.not_to raise_error
    expect(episode.video_transcoded_at).to be_present
    expect(episode).to be_video_transcoded
  end
end
