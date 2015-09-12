require "rails_helper"

RSpec.describe AudioTranscoder, type: :worker do
  it "uses the audio pipeline id from secrets" do
    expect(worker.pipeline_id).to eq(Rails.application.secrets.aws_audio_pipeline_id)
  end

  it "uses the new extension" do
    expect(worker.new_extension).to eq('m3u8')
  end
end
