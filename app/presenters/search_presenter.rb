class SearchPresenter < ApplicationPresenter
  def results
    model.results.map do |result|
      SearchResultPresenter.new result
    end
  end
end
