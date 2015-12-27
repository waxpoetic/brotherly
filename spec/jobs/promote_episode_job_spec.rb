require 'rails_helper'

RSpec.describe PromoteEpisodeJob, type: :job do
  let :episode do
    episodes :four
  end

  it 'promotes episode on all found promoters' do
    expect(PromoteEpisodeJob.perform_now(episode)).to eq []
  end
end
