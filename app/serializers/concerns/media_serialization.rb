module MediaSerialization
  def audio
    attachment_url model, :audio_file
  end

  def video
    attachment_url model, :video_file
  end
end
