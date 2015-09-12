require "rails_helper"

RSpec.describe VideoTranscoder, type: :worker do
  it "uses the video pipeline id" do
    expect(worker.pipeline_id).to eq(Rails.application.secrets.aws_video_pipeline_id)
  end

  it "uses an m3u8 extension" do
    expect(worker.new_extension).to eq('m3u8')
  end
end
