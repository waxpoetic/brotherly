# frozen_string_literal: true

module Mailchimp
  class Subscriber
    include ActiveModel::Model

    # Name of the new subscriber
    #
    # @attr_accessor [String]
    attr_accessor :name

    # Email of the new subscriber
    #
    # @attr_accessor [String]
    attr_accessor :email

    validates :email, presence: true

    # Subscribe a user to the list on Mailchimp.
    #
    # @option [String] email
    # @option [String] name
    # @return [Mailchimp::Subscriber]
    def self.create(email: '', name: '')
      subscriber = new email: email, name: name
      subscriber.save
      subscriber
    end

    # Subscribe to Mailchimp after validating.
    #
    # @return [Boolean]
    def save
      valid? && create.success?
    end

    # Test if the response succeeded.
    #
    # @return [Boolean]
    def persisted?
      @response&.success?
    end

    private

    # @private
    # @return [Mailchimp::Response]
    def create
      @response = Mailchimp::Gateway.for_env.create_member(
        email_address: email,
        status: 'subscribed',
        merge_fields: {
          NAME: name
        }
      )
    rescue Gibbon::GibbonError, Gibbon::MailChimpError => exception
      errors.add :base, exception.message
      Response.new 'gibbon_error' => exception.message
    end
  end
end
