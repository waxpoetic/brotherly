require 'rails_helper'

RSpec.feature 'Episodes', type: :feature do
  let :episode do
    episodes :four
  end

  scenario 'listing' do
    visit episodes_path

    expect(page).to have_content(t('episodes.listing'))
    expect(page).to have_content(episode.name)
  end

  scenario 'latest (home page)' do
    visit root_path

    expect(page).to have_content(t('episodes.next'))
    expect(page).to have_content(episode.name)
  end

  scenario 'click through to details' do
    visit root_path
    click_link episode.name
    expect(page).to have_content(episode.name)
    expect(page).to have_content(t('episodes.tickets'))
  end

  scenario 'details for upcoming episode' do
    episode.update(
      youtube_id: nil,
      starts_at: 1.hour.from_now,
      ends_at: 2.hours.from_now
    )
    visit episode_path(episode, format: 'html')

    expect(page).to have_content(episode.name)
    expect(page).to have_content(t(:title, scope: :artists))
    expect(page).to have_content(episode.artists.first.name)
    expect(page).to have_css('#flyer')
  end

  scenario 'details for current episode' do
    episode.update(
      youtube_id: 'Mg-LfxWY5hc',
      starts_at: 1.hour.ago,
      ends_at: 2.hours.from_now
    )
    visit episode_path(episode, format: 'html')

    expect(page).to have_content(episode.name)
    expect(page).to have_content(t(:title, scope: :artists))
    expect(page).to have_content(episode.artists.first.name)
    expect(page).to have_css('#stream')
    expect(page).to have_css('#stream[autoplay]')
  end

  scenario 'details for past episode' do
    episode.update(
      youtube_id: 'Mg-LfxWY5hc',
      starts_at: 2.hours.ago
    )
    visit episode_path(episode, format: 'html')

    expect(page).to have_content(episode.name)
    expect(page).to have_content(t(:title, scope: :artists))
    expect(page).to have_content(episode.artists.first.name)
    expect(page).to have_css('#stream')
  end
end
