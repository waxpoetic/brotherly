class Event < ApplicationRecord
  before_validation :parse_google_timestamps

  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  scope :recent, -> { where 'starts_at >= ?', Time.current }

  after_create :obtain_facebook_data

  def self.parse_date(google_time)
    google_time.date_time || google_time.date
  end

  def all_day?
    !starts_at.is_a?(DateTime)
  end

  def facebook_url
    description if description.starts_with? 'http'
  end

  private

  def parse_google_timestamps
    self.starts_at ||= self.class.parse_date(starts_at)
    self.ends_at   ||= self.class.parse_date(ends_at)
  end

  def obtain_facebook_data
    FacebookifyEventJob.perform_later self
  end
end
