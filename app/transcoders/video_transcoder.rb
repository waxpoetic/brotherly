class VideoTranscoder < Brotherly::Transcoder
  def pipeline_id
    Rails.application.secrets.aws_video_pipeline_id
  end

  def new_extension
    'm3u8'
  end
end
