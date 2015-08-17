require 'rails_helper'

RSpec.feature "Episodes", type: :feature do
  let :episode do
    episodes :one
  end

  scenario "listing" do
    visit episodes_path

    expect(page).to have_content('All Episodes')
    expect(page).to have_content(episode.name)
  end

  scenario "latest (home page)" do
    visit root_path

    expect(page).to have_content('latest episode')
    expect(page).to have_content(episode.name)
  end

  scenario 'click through to details' do
    visit root_path
    click_link episode.name
    expect(page).to have_content(episode.name)
    expect(page).to have_content('Get Tickets')
  end

  scenario "details" do
    visit episodes_path(episode)

    expect(page).to have_content(episode.name)
    expect(page).to have_content('Artists')
    expect(page).to have_content(episode.performances.first.name)
  end
end
