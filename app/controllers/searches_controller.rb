# frozen_string_literal: true
class SearchesController < ApplicationController
  def show
    @search = Search.create params[:search][:query]
    respond_with search
  end
end
