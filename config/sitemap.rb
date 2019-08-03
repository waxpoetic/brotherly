# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://www.brother.ly'

SitemapGenerator::Sitemap.create do
  add episodes_path, changefreq: 'monthly'
  Episode.all.each do |episode|
    add episode_path(episode), lastmod: episode.updated_at, priority: 0.6, changefreq: 'never'
  end

  add artists_path, changefreq: 'monthly'
  Artist.all.each do |artist|
    add artist_path(artist), lastmod: artist.updated_at, priority: 0.7, changefreq: 'never'
  end
end
