module Media
  extend ActiveSupport::Concern

  included do
    delegate :cloudcast_key
  end

  def video?
    model.youtube_id.present?
  end

  def youtube_url
    "http://www.youtube.com/?v=#{model.youtube_id}"
  end

  def youtube_embed_url
    "http://www.youtube.com/embed/#{model.youtube_id}"
  end

  def downloadable?
    model.audio_file.present?
  end

  def video_player
    h.content_tag :iframe, video_tag_options do
      'Connecting...'
    end
  end

  def audio_player
    h.content_tag :iframe, data: { 'cloudcast-key' => cloudcast_key } do
      'Connecting...'
    end
  end

  def video_tag_options
    {
      id: 'stream',
      width: 640,
      height: 400,
      src: youtube_embed_url,
      frameborder: 0,
      allowfullscreen: true
    }
  end
end
