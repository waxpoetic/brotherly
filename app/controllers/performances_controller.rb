# frozen_string_literal: true

class PerformancesController < ApplicationController
  resource :performance

  def show
    respond_with @performance
  end
end
