class SearchesController < ApplicationController
  expose :search, attributes: :search_params

  def show
    respond_with search
  end

  private

  def search_params
    params.permit :query
  end
end
