class AddSubscriberJob < ActiveJob::Base
  queue_as :default

  def perform(subscriber)
    Mailchimp::Subscriber.create(
      list: list,
      email: subscriber.email,
      name: subscriber.name
    )
  end
    list.members.create(
      body: {
        email_address: subscriber.email,
        status: 'subscribed',
        merge_fields: {
          NAME: subscriber.name
        }
      }
    )
  end

  private

  def list
    @list ||= mailchimp.lists(
      Rails.application.secrets.mailchimp_list_id
    )
  end

  def mailchimp
    @mailchimp ||= Gibbon::Request.new(
      api_key: Rails.application.secrets.mailchimp_api_key
    )
  end
end
