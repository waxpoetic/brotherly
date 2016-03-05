class GenerateSitemapJob < ActiveJob::Base
  queue_as :default

  def perform
    require "#{Rails.root}/config/sitemap.rb"
  end
end
