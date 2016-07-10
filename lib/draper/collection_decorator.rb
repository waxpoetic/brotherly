module Draper
  class CollectionDecorator < Decorator
    include Enumerable

    class_attribute :model_class_name
    class_attribute :decorator
    self.model_class_name ||= name.gsub(/Decorator/, '').classify
    self.decorator ||= "#{model_class_name}Decorator".constantize

    def each
      model.each { |record| yield record.decorate(with: decorator) }
    end
  end
end
