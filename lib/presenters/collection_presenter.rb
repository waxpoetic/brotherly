module Presenters
  # Presents +ActiveRecord::Relation+ objects as collections of
  # presented models.
  class CollectionPresenter < Presenter
    prepend Enumerable

    class_attribute :presenter_name

    # Whenever model data is needed, records are first presented with
    # the configured object.
    def each
      model.each { |record| yield record.present(with: presenter) }
    end

    private

    def presenter
      configured_presenter_name.constantize
    end

    def configured_presenter_name
      presenter_name || "#{model_class_name}Presenter"
    end

    def model_class_name
      self.class.name.gsub(/Presenter/, '').classify
    end
  end
end
