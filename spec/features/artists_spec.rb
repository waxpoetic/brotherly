# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Artists', type: :feature do
  let :artist do
    artists :rnd
  end

  scenario 'can be viewed on the roster' do
    visit artists_path(format: 'html')

    expect(page).to have_content(artist.name)

    click_link artist.name

    expect(page).to have_content(artist.name)
  end

  scenario 'can be visited directly' do
    visit artists_path(artist, format: 'html')

    expect(page).to have_content(artist.name)
    expect(page).to have_content(artist.description)
  end
end
