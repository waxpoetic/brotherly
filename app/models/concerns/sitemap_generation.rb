module SitemapGeneration
  extend ActiveSupport::Concern

  included do
    after_save :regenerate_sitemap
    after_destroy :regenerate_sitemap
  end

  def regenerate_sitemap
    GenerateSitemapJob.perform_later
  end
end
