class Episode < ActiveRecord::Base
  has_many :performances

  attachment :video_recording
  attachment :audio_recording

  after_create :promote

  scope :latest, -> { order :starts_at }

  def future?
    starts_at >= Time.current
  end

  private

  def promote
    PromoteEpisodeJob.perform_later self
  end
end
