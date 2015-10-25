require 'draper/decoratable'

module Brotherly
  module Decoratable
    extend ActiveSupport::Concern

    included do
      include Draper::Decoratable
    end

    def decorate(options = {})
      return super unless options[:controller].class.name =~ /\AAdmin::/
      admin_decorator_class.decorate(self, options)
    end

    private

    def admin_decorator_class
      "Admin::#{decorator_class}".constantize
    end
  end
end
