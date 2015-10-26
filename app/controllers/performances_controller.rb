class PerformancesController < ApplicationController
  expose :performance

  def show
    respond_with performance
  end
end
