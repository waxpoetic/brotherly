module MediaDecoration
  def audio
    h.attachment_url model, :audio_file
  end

  def audio?
    model.audio_file_id.present?
  end

  def video
    h.attachment_url model, :video_file, extension: 'm3u8'
  end

  def video?
    model.video_file_id.present?
  end
end
