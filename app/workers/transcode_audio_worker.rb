class TranscodeAudioWorker < TranscodeWorker
  def pipeline_id
    secrets.aws_audio_pipeline_id
  end

  def new_extension
    'm3u8'
  end
end
