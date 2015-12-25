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
    searchable_type == 'performance' ? 'episode_performance' : searchable_type
  end

  def searchable_type
    model.searchable_type.downcase
  end
end
