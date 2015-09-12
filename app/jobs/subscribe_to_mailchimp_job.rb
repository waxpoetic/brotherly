class SubscribeToMailchimpJob < ActiveJob::Base
  queue_as :default

  def perform(model)
    SubscribeToMailchimpWorker.perform(model)
  end
end
