class ApplicationDecorator < Draper::Decorator
  # All field names for the decorated model.
  #
  # @return [Array<Symbol>
  def fields
    model.class.column_names.reject do |column|
      column =~ /id|name|type|created_at|updated_at/
    end
  end

  # Default title of every show and edit page.
  #
  # @return [String]
  def title
    model.name.titleize
  end

  def self.collection_decorator_class
    CollectionDecorator
  end
end
