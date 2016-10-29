# frozen_string_literal: true
module MetadataHelper
  def logo_image_url
    image_url 'logo.jpg'
  end

  def meta_keywords
    config.keywords.join(', ')
  end

  def meta_title
    page_title || app_title
  end

  def meta_description
    @episode&.description || config.description
  end

  def meta_share_image
    @episode&.flyer_image_url || logo_image_url
  end

  def open_graph_type
    if @episode.present?
      'video.episode'
    elsif @artist.present?
      'profile'
    elsif @article.present?
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
