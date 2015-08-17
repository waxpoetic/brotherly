class Episode < ActiveRecord::Base
  has_many :artists, through: :performances

  after_create :promote

  def self.next
    order(:starts_at).first
  end

  private

  def promote
    PromoteEpisodeJob.perform_later self
  end
end
