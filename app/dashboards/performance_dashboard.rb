# frozen_string_literal: true

require 'administrate/base_dashboard'

class PerformanceDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    artist: Field::BelongsTo,
    episode: Field::BelongsTo,
    id: Field::Number,
    starts_at: Field::DateTime,
    ends_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    video_url: Field::String,
    image: UploadField
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    episode
    artist
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    artist
    episode
    starts_at
    ends_at
    video_url
    image
  ].freeze

  # Overwrite this method to customize how performances are displayed
  # across all pages of the admin dashboard.
  def display_resource(performance)
    performance.name
  end
end
