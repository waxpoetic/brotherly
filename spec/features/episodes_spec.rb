require 'rails_helper'
require 'refile/file_double'

RSpec.feature 'Episodes', type: :feature do
  let :episode do
    episodes :four
  end

  let :video do
    Refile::FileDouble.new(
      'archive', 'video.mp4', content_type: 'video/mp4'
    )
  end

  scenario 'listing' do
    visit episodes_path

    expect(page).to have_content(t('episodes.listing'))
    expect(page).to have_content('next...')
  end

  scenario 'latest (home page)' do
    visit root_path

    expect(page).to have_content('next...')
  end

  scenario 'click through to details' do
    visit root_path
    click_link 'brother.ly three'
    expect(page).to have_content('brother.ly three')
  end

  scenario 'details for upcoming episode' do
    episode.update(
      youtube_id: nil,
      starts_at: 1.hour.from_now,
      ends_at: 2.hours.from_now
    )
    visit episode_path(episode, format: 'html')

    expect(page).to have_content(episode.name)
    expect(page).to have_content(t('episodes.lineup'))
    expect(page).to have_content(episode.artists.first.name)
    expect(page).to have_css('.flyer_file')
  end

  scenario 'details for current episode' do
    episode.update(
      youtube_id: 'Mg-LfxWY5hc',
      starts_at: 1.hour.ago,
      ends_at: 2.hours.from_now
    )
    visit episode_path(episode, format: 'html')

    expect(episode.decorate).to be_streaming
    expect(page).to have_content(episode.name)
    expect(page).to have_content('Lineup')
    expect(page).to have_content(episode.artists.first.name)
    expect(page).to have_css('#stream')
    expect(page).to have_css('#stream[autoplay]')
  end

  scenario 'details for past episode' do
    episode.update(
      youtube_id: 'Mg-LfxWY5hc',
      starts_at: 2.hours.ago,
      ends_at: 1.hour.ago,
      video_file: video
    )
    visit episode_path(episode, format: 'html')

    expect(episode.decorate).to be_archived
    expect(page).to have_content(episode.name)
    expect(page).to have_content(t('episodes.lineup'))
    expect(page).to have_content(episode.artists.first.name)
    expect(page).to have_css('#archive')
  end
end
