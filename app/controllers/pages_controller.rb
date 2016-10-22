class PagesController < ApplicationController
  def home
    @episode = present Episode.current
    @episodes = present Episode.latest
  end
end
