class RecommendationPresenter < ApplicationPresenter
  # Width of all preview images in px
  IMAGE_WIDTH = 220

  # Height of all preview images in px
  IMAGE_HEIGHT = 120

  # Create +RecommendationPresenter+ objects for each model in a given
  # collection.
  #
  # @param collection [Array<ApplicationRecord>] Collection of models.
  # @return [Array<RecommmendationPresenter>] Presented models
  def self.wrap(collection)
    collection.map do |model|
      present model
    end
  end

  # Text underneath the image
  def caption
    model.name
  end

  # URL that the link points to
  def url
    if performance?
      h.url_for model.episode, model
    else
      h.url_for model
    end
  end

  # Preview image
  def image
    h.attachment_image_tag(
      model,
      :image,
      :fill,
      IMAGE_WIDTH,
      IMAGE_HEIGHT,
      fallback: fallback_image_url
    )
  end

  private

  # @private
  def fallback_image_url
    "http://placehold.it/#{IMAGE_WIDTH}x#{IMAGE_HEIGHT}?text=#{caption}"
  end
end
