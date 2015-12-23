module Mailchimp
  class Subscriber
    include ActiveModel::Model

    attr_accessor :list, :email, :name

    validates :list, presence: true
    validates :email, presence: true
    validates :name, presence: true

    def self.create(params = {})
      subscriber = new(params)
      subscriber.save
      subscriber
    end

    def save
      valid? && create
    end

    private

    def create
      Mailchimp.gateway.create_member(
        email_address: email,
        status: 'subscribed',
        merge_fields: {
          NAME: name
        }
      )
    end
  end
end
