# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PagesController, type: :request do
  it 'renders about page' do
    get about_path

    expect(response).to be_successful
  end

  it 'renders robots.txt' do
    get robots_path(format: :text)

    expect(response).to be_successful
    expect(response.body).to include('User-Agent: *')
    expect(response.body).to include('Disallow: /admin')
  end
end
