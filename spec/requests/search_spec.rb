require 'rails_helper'

RSpec.describe 'Search' do
  describe 'GET /search' do
    it 'runs a search query when params are given' do
      get search_path search: { query: 'test' }
      expect(response).to have_http_status(200)
    end

    it 'runs empty search query when no params are given' do
      get search_path
      expect(response).to have_http_status(200)
    end
  end
end
