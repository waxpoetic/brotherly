# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Performances', type: :feature do
  let :performance do
    performances :mr_jennings_at_three
  end

  let :episode do
    performance.episode
  end

  let :cover do
    Refile::FileDouble.new 'cover_image', 't.jpg', content_type: 'image/jpeg'
  end

  before do
    performance.update video_url: 'http://example.com', image: cover
  end

  scenario 'can be visited directly' do
    visit episode_performance_path(episode, performance)

    expect(page).to have_content(performance.artist.name)
    expect(page).to have_css('video')
  end

  scenario 'can be clicked into via their episodes' do
    visit episodes_path

    click_link episode.name

    expect(page).to have_content(episode.name)
    expect(page).to have_content(performance.artist.name)

    click_link performance.artist.name

    expect(page).to have_content(performance.artist.name)
    expect(page).to have_css('video')
  end
end
