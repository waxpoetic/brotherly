require 'rails_helper'

RSpec.describe TranscodeEpisodeJob, type: :job do
  let(:episode) { episodes :one }
  subject { described_class }

  it 'runs the transcode worker in the background' do
    expect(subject.perform(episode)).not_to raise_error
  end
end
