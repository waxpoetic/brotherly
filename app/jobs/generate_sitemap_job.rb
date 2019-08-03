# frozen_string_literal: true

class GenerateSitemapJob < ApplicationJob
  queue_as :default

  def perform
    require Rails.root.join('config', 'sitemap.rb')
  end
end
