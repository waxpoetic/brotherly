class SearchResultDecorator < ApplicationDecorator
  delegate_all

  def name
    model.content
  end

  def href
    h.send route, model.searchable_id
  end

  private

  def route
    "#{model.searchable_type.downcase}_path"
  end
end
