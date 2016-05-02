require 'rails_helper'

RSpec.describe GenerateShortLinkJob, type: :job do
  let :episode do
    episodes :four
  end

  let :result do
    VCR.use_cassette :generate_short_link do
      subject.perform(episode)
    end
  end

  subject do
    described_class.new
  end

  it "generates a bitly short link for a given episode's eventbrite url" do
    expect(result).to be true
    expect { episode.reload }.not_to raise_error
    expect(episode.short_link_url).to be_present
  end
end
