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
    h.titleize model.name
  end

  def self.collection_decorator_class
    CollectionDecorator
  end

  def created_at
    model.created_at.to_s :short
  end

  def updated_at
    "#{h.time_ago_in_words(model.updated_at)} ago"
  end
end
