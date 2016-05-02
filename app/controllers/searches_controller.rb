class SearchesController < ApplicationController
  expose :search do
    Search.create search_params
  end

  def show
    respond_with search
  end

  private

  def search_params
    if params[:search]
      params[:search][:query]
    else
      ''
    end
  end
end
