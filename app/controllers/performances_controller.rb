class PerformancesController < ApplicationController
  expose :episode
  expose :performance, ancestor: :episode

  def show
    respond_with performance
  end
end
