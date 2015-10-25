class SearchResultDecorator < ApplicationDecorator
  delegate_all

  def name
    model.content
  end

  def href
    h.send "#{model.searchable_type.downcase}_path", model.searchable_id
  end
end
