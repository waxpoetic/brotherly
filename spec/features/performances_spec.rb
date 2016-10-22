# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Performances', type: :feature do
  let :performance do
    performances :del_at_four
  end

  scenario 'go to a performance by its episode' do
    skip 'not yet implemented'
    visit episodes_path(performance.episode, format: 'html')
    click_link performance.artist.name
    expect(page).to have_content(performance.artist.name)
    expect(page).to have_content(performance.episode.name)
  end
end
