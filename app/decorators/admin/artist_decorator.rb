class Admin::ArtistDecorator < AdminDecorator
  decorates Artist
  delegate_all

  def title
    model.name
  end
end
