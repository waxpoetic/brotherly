class SubscribeToMailchimpWorker < Brotherly::Worker
  delegate :name, :email, to: :model

  def perform
    list.members.create(
      body: {
        email_address: email,
        status: 'subscribed',
        merge_fields: {
          NAME: name
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
