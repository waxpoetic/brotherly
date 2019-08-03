# frozen_string_literal: true

module Podcast
  def audio
    h.attachment_url model, :audio_file
  end

  def audio?
    model.audio_file_id.present?
  end

  def video?
    model.video_url.present?
  end

  def enclosure
    {
      url: audio,
      length: audio_file.download.size,
      type: 'audio/mp3'
    }
  end

  def explicit
    'no'
  end

  def duration
    360
  end

  def title
    model.name
  end

  def subtitle
    h.truncate model.description, length: 100
  end

  def published_at
    return unless model.published_at

    model.published_at.to_s(:rfc822)
  end

  def posted_at
    return if model.published_at.present?

    h.distance_of_time_in_words model.published_at
  end
end
