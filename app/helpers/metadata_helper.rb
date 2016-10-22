module MetadataHelper
  def logo_image_url
    image_url 'logo.png', host: Rails.configuration.action_controller.asset_host
  end

  def seo_keywords
    config.keywords.join(', ')
  end
end
