# frozen_string_literal: true

class RecommendationPresenter < Makeover::Presenter
  def caption
    model.is_a?(Performance) ? model.artist.name : model.name
  end

  def image
    h.image_url image_record.send(image_attribute).variant(fill: '240x160')
  end

  private

  def image_record
    model.is_a?(Performance) ? model.artist : model
  end

  def image_attribute
    model.is_a?(Performance) ? :cover_image : :flyer_file
  end
end
