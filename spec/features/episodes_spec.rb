# frozen_string_literal: true
require 'rails_helper'
require 'refile/file_double'

RSpec.feature 'Episodes', type: :feature do
  let :current_episode do
    episodes :current
  end

  let :video do
    Refile::FileDouble.new(
      'archive', 'video.mp4', content_type: 'video/mp4'
    )
  end

  xscenario 'home page' do
    visit root_path

    expect(page).to have_content current_episode.name
    expect(page).to have_css '#stream'
  end

  xscenario 'archive' do
    visit episodes_path

    expect(page).to have_content 'past episodes'
  end

  xscenario 'upcoming' do
    visit upcoming_episodes_path

    expect(page).to have_content 'upcoming episodes'
  end

  xscenario 'detail' do
    visit episode_path(episode)

    expect(page).to have_content episode.name
  end
end
