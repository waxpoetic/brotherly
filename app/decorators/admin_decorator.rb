class AdminDecorator < ApplicationDecorator
  HIDDEN_COLUMNS = /\A(id|name|type|created_at|updated_at)\Z/

  # All field names for the decorated model.
  #
  # @return [Array<Symbol>
  def fields
    model.class.column_names.reject do |column|
      column =~ HIDDEN_COLUMNS
    end
  end

  # Generate a link to this model in a modal dialog.
  #
  # @return [String]
  def name
    h.link_to_modal title, [:admin, model]
  end

  def created_at
    model.created_at.to_s :long
  end

  def updated_at
    h.time_ago_in_words(model.updated_at) + ' ago'
  end
end
