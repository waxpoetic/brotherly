require 'rails_helper'

RSpec.describe "Episodes", type: :request do
  describe "GET /episodes.rss" do
    let :episode do
      episodes :one
    end

    before do
      episode.update(
        audio_file_id: '12345'
      )
    end

    it "shows the podcast" do
      get episodes_path(format: 'rss')

      expect(response).to have_http_status(200)
      expect(response.body).to match(/<rss (.*)>/)
      expect(response.body).to include('<channel>')
      expect(response.body).to include('<item>')
    end
  end
end
