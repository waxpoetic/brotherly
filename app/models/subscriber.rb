class Subscriber < ActiveRecord::Base
  validates :email, presence: true, email: true

  # after_create :add!

  private
  def add!
    AddSubscriberJob.perform_later self
  end
end
