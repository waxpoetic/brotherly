require 'rails_helper'

RSpec.feature 'View page', type: :feature do
  scenario 'mission statement' do
    visit about_path

    expect(page).to have_content('About')
  end

  scenario 'events calendar' do
    visit calendar_path

    expect(page).to have_content('events calendar')
    expect(page).to have_css('iframe')
  end
end