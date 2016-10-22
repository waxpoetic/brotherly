# frozen_string_literal: true
module EpisodesHelper
  # Unmodified CSS class for filmstrip episode links.
  INITIAL_LINK_CLASS = 'filmstrip__episode'

  def filmstrip_link_class(*routes)
    if current_page?(routes)
      INITIAL_LINK_CLASS + '--active'
    else
      INITIAL_LINK_CLASS
    end
  end

  def youtube_stream(src: '', autoplay: 'autoplay')
    tag :iframe, \
        id: 'stream',
        width: EpisodePresenter::VIDEO_WIDTH,
        src: src,
        frameborder: 0,
        allowfullscreen: true,
        autoplay: autoplay
  end

  def podcast_cache_key(section = nil)
    max_updated_at = @episodes.last.updated_at.try(:utc)
    last_updated_at = max_updated_at.try(:to_s, :number) || '0'

    if section
      "podcast/#{last_updated_at}/#{section}"
    else
      "podcast/#{last_updated_at}"
    end
  end
end
