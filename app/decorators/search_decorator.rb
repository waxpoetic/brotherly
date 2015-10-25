class SearchDecorator < ApplicationDecorator
  delegate_all

  def results
    model.results.map do |result|
      SearchResultDecorator.new result
    end
  end
end
