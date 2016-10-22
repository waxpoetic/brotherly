# frozen_string_literal: true
require 'rails_helper'

RSpec.describe TranscodeVideoJob, type: :job do
  let :episode do
    episodes :three
  end

  let :video do
    double(
      id: SecureRandom.hex
    )
  end

  subject do
    described_class.new
  end

  it 'starts a transcode for video' do
    VCR.use_cassette :transcode_three do
      allow(episode).to receive(:video_file_id).and_return(video.id)
      expect(subject.perform(episode)).to be true
      expect { episode.reload }.not_to raise_error
      expect(episode.video_transcoded_at).to be_present
      expect(episode).to be_transcoded
    end
  end
end
