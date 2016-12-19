# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EpisodePresenter do
  let(:episode) { episodes :one }
  subject { described_class.new episode }

  context '#autoplay?' do
    it 'allows for youtube autoplay when currently streaming' do
      episode.ends_at = 1.hour.from_now
      expect(subject).to be_autoplay
    end

    it 'does not autoplay video after live show concludes' do
      episode.ends_at = 1.hour.ago
      expect(subject).not_to be_autoplay
    end

    it 'always allows autoplay when end date is blank' do
      episode.ends_at = nil
      expect(subject).to be_autoplay
    end

    it 'never allows autoplay when start date is blank' do
      episode.starts_at = nil
      expect(subject).not_to be_autoplay
    end
  end

  context '#video' do
    it 'returns nil unless the video is transcoded' do
      expect(subject).not_to be_video
    end
  end
end
