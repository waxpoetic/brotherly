class PodcastDecorator < EpisodesDecorator
  def self.decorator_class
    PodcastEpisodeDecorator
  end

  def cache_key
    "#{model.cache_key}/podcast"
  end

  def channel
    id = Digest::SHA1.new pieces.join('')
    "podcast/channel/#{id}"
  end

  def name
    Rails.configuration.name
  end

  def link
    Rails.secrets.domain_name
  end

  def description
    Rails.configuration.description
  end

  def language
    I18n.locale.to_s || 'en'
  end

  def published_at
    model.last.published_at
  end

  def author
    Rails.configuration.podcast_author
  end

  def keywords
    Rails.configuration.keywords.join(', ')
  end

  def email
    'podcast@brother.ly'
  end

  def category
    'Music'
  end

  def pieces
    [name, link, published_at, author, keywords, explicicity]
  end
end
