class Artist < ActiveRecord::Base
  has_many :episodes, through: :performances
end
