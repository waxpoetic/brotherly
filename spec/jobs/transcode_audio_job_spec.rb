require 'rails_helper'

RSpec.describe TranscodeAudioJob, type: :job do
  let :performance do
    performances :frank_sriracha_at_four
  end

  subject do
    described_class.new
  end

  it 'starts a transcode for audio' do
    VCR.use_cassette :audio_transcode do
      expect(subject.perform(performance)).to be true
      expect { performance.reload }.not_to raise_error
      expect(performance.audio_transcoded_at).to be_present
      expect(performance).to be_audio_transcoded
    end
  end
end
