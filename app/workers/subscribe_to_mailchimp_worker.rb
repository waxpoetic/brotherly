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
    @list ||= mailchimp.lists(list_id)
  end

  def list_id
    Rails.application.config.secrets.mailchimp_list_id
  end

  def api_key
    Rails.application.config.secrets.mailchimp_api_key
  end

  def mailchimp
    @mailchimp ||= Gibbon::Request.new api_key: api_key
  end
end
