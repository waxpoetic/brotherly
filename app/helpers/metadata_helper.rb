module MetadataHelper
  def logo_image_url
    image_url 'logo.jpeg', host: Rails.configuration.action_controller.asset_host
  end

  def meta_keywords
    config.keywords.join(', ')
  end

  def meta_title
    if page_title.present?
      page_title
    else
      app_title
    end
  end

  def meta_description
    if @episode.present?
      @episode.description
    else
      config.description
    end
  end

  def meta_share_image
    @episode&.cover_image_url || logo_image_url
  end

  def open_graph_type
    case
    when @episode.present?
      'video.episode'
    when @artist.present?
      'profile'
    when @article.present?
      'article'
    else
      'website'
    end
  end

  def twitter_card
    if @episode.present? && @episode.archived?
      'player'
    else
      'summary_large_image'
    end
  end
end
