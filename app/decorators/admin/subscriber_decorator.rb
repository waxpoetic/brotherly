class Admin::SubscriberDecorator < ApplicationDecorator
  decorates Subscriber
  delegate_all

  def created_at
    h.time_ago_in_words(model.created_at) + ' ago'
  end
end
