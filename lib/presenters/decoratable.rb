module Presenters
  module Presentable
    extend ActiveSupport::Concern

    def decorate(with: nil, **options)
      current_decorator = with || decorator
      current_decorator.new self, **options
    end

    private

    def decorator
      "#{self.class.name}Presenter".constantize
    end
  end
end
