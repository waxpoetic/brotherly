class SearchDecorator < Draper::Decorator
  delegate_all

  def results
    model.results.map do |result|
      SearchResultDecorator.new result
    end
  end
end
