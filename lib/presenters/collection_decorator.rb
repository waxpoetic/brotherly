module Presenters
  class CollectionPresenter < Presenter
    include Enumerable

    class_attribute :model_class_name
    class_attribute :decorator
    self.model_class_name ||= name.gsub(/Presenter/, '').classify
    self.decorator ||= "#{model_class_name}Presenter".constantize

    def each
      model.each { |record| yield record.decorate(with: decorator) }
    end
  end
end
