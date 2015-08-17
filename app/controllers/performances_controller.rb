class PerformancesController < ApplicationController
  expose :episode
  resource :performance, ancestor: :episode

  def show
    respond_with performance
  end
end
