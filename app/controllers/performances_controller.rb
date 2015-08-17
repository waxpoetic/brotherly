class PerformancesController < ApplicationController
  expose :episode
  resource :performance, ancestor: :episode

  def index
    respond_with performances
  end

  def show
    respond_with performance
  end
end
