# frozen_string_literal: true

class AddSubscriberJob < ApplicationJob
  queue_as :default

  def perform(subscriber)
    Mailchimp::Subscriber.create(
      name: subscriber.name,
      email: subscriber.email
    )
  end
end
