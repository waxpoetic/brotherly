require 'rails_helper'

RSpec.describe PromoteEpisodeJob, type: :job do
  let :episode do
    episodes :four
  end

  it 'promotes episode on all found services' do
    expect(PromoteEpisodeJob.perform_now(episode)).to eq true
  end
end
