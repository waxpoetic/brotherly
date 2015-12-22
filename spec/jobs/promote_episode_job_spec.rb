require 'rails_helper'

RSpec.describe PromoteEpisodeJob, type: :job do
  let :episode do
    episodes :four
  end

  it 'promotes episode on all found services' do
    allow_any_instance_of(Brotherly::ShortLink).to receive(:create).and_return(
      double('Link', short_url: 'test')
    )
    expect(PromoteEpisodeJob.perform_now(episode)).to eq true
  end
end
