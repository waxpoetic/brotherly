require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.brother.ly'
SitemapGenerator::Sitemap.create do
  add '/',          changefreq: 'monthly', priority: 1.0
  add '/episodes',  changefreq: 'monthly', priority: 0.9
  add '/artists',   changefreq: 'monthly', priority: 1.0

  Episode.all.each do |episode|
    add "/episodes/#{episode.slug}"

    # episode.performances.each do |performance|
    #   add "/episodes/#{episode.slug}/performances/#{performance.slug}"
    # end

    episode.artists.each do |artist|
      add "/artists/#{artist.slug}"
    end
  end
end
