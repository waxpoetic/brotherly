class Subscriber < ActiveRecord::Base
  validates :email, presence: true, email: true

  def subscribe
    SubscribeToMailchimpJob.perform_later self
  end
end
