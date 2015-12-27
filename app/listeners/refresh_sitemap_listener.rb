class RefreshSitemapListener < Brotherly::Listener
  on :created, :destroyed

  def perform
    load Rails.root.join('config', 'sitemap.rb')
    SitemapGenerator::Sitemap.ping_search_engines
  end
end
