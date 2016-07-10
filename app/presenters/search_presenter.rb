class SearchPresenter < ApplicationPresenter
  delegate_all

  def results
    model.results.map do |result|
      SearchResultPresenter.new result
    end
  end
end
