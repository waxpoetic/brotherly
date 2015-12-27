class RefreshSitemapListener < Brotherly::Listener
  on :created, :destroyed

  def perform
    return unless Rails.env.production?
    load Rails.root.join('config', 'sitemap.rb')
    SitemapGenerator::Sitemap.ping_search_engines
  end
end
