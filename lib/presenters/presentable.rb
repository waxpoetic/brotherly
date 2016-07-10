module Presenters
  module Presentable
    extend ActiveSupport::Concern

    included do
      class_attribute :custom_presenter
      alias_method :decorate, :present
    end

    def present(with: nil, **options)
      current_presenter = with || presenter
      current_presenter.new self, **options
    end

    private

    def presenter
      self.class.custom_presenter || "#{self.class.name}Presenter".constantize
    end
  end
end
