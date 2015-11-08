class Subscriber < ActiveRecord::Base
  validates :email, presence: true, email: true

  after_create :add!
end
