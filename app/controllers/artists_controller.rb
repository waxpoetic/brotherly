# frozen_string_literal: true

class ArtistsController < ApplicationController
  resource :artist

  def index
    respond_with @artists
  end

  def show
    respond_with @artist
  end
end
