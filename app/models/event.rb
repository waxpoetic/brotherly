class Event < ApplicationRecord
  validates :name, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  def self.parse_date(google_time)
    google_time.date_time || google_time.date
  end

  def all_day?
    !starts_at.is_a?(DateTime)
  end
end
