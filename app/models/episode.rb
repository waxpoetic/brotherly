class Episode < ActiveRecord::Base
  include Recordable

  has_many :performances

  accepts_nested_attributes_for :performances

  after_create :promote
  after_create :generate_short_url

  scope :latest, -> { order :starts_at }

  friendly_id :name

  def future?
    starts_at >= Time.current
  end

  def published?
    published_at.present?
  end

  def promote
    PromoteEpisodeJob.perform_later self
  end

  def publish
    PublishEpisodeJob.perform_later self
  end

  private

  def generate_short_url
    GenerateEpisodeLink.perform_later self
  end
end
