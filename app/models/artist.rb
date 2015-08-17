class Artist < ActiveRecord::Base
  has_many :episodes, through: :performances

  validates :name, presence: true
end
