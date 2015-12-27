module Media
  def audio?
    model.audio_file.present?
  end

  def video?
    model.youtube_id.present?
  end

  def video_url
    "http://www.youtube.com/?v=#{model.youtube_id}"
  end

  def audio_url
    h.attachment_url model, :audio_file, extension: 'mp3'
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
      src: "http://www.youtube.com/embed/#{model.youtube_id}",
      frameborder: 0,
      allowfullscreen: true
    }
  end
end
