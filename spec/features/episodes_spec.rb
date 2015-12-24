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

  scenario 'details' do
    visit episodes_path(episode, format: 'html')

    expect(page).to have_content(episode.name)
    expect(page).to have_content(t(:title, scope: :artists))
    expect(page).to have_content(episode.artists.first.name)
  end
end
