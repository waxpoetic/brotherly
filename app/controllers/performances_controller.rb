class PerformancesController < ApplicationController
  expose :episode
  expose :performance do
    episode.performances.find params[:id]
  end

  def show
    respond_with performance
  end
end
