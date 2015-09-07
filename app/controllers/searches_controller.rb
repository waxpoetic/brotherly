class SearchesController < ApplicationController
  expose :search do
    Search.create params[:search][:query]
  end

  def show
    respond_with search
  end
end
