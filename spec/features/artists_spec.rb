require 'rails_helper'

RSpec.feature 'Artists', type: :feature do
  let :artist do
    artists :rnd
  end

  scenario 'view list of artists' do
    visit artists_path(format: :html)
    expect(page).to have_content(artist.name)
  end

  scenario 'view single artist' do
    visit artists_path(artist)
    expect(page).to have_content(artist.name)
    expect(page).to have_content(artist.description)
  end

  scenario 'view single artist from list of artists' do
    visit artists_path
    click_link artist.name
    expect(page).to have_content(artist.name)
  end
end
