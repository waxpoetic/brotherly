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
    "#{kind}_url"
  end

  def kind
    model.searchable_type.downcase
  end
end
