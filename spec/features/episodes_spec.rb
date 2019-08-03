# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Episodes', type: :feature do
  let :episode do
    episodes :four
  end

  let :video do
    Refile::FileDouble.new(
      'archive', 'video.mp4', content_type: 'video/mp4'
    )
  end

  before do
    episode.update starts_at: 1.hour.ago, ends_at: 1.hour.from_now
  end

  scenario 'archive' do
    visit episodes_path

    expect(page).to have_content 'past episodes'
  end

  scenario 'upcoming' do
    visit upcoming_episodes_path

    expect(page).to have_content 'upcoming episodes'
  end

  scenario 'detail' do
    visit episode_path(episode)

    expect(page).to have_content episode.name
  end
end
