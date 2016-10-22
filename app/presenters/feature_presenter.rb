# frozen_string_literal: true
# Article features on the sidebar are wrapped in this object.
class FeaturePresenter < ApplicationPresenter
  def url
    url_for model
  end

  def image
    model_presenter.cover_image_url
  end

  def title
    model_presenter.feature_title
  end

  def style
    "background-image: url('#{image}');"
  end

  private

  def model_presenter
    model.present
  end
end
