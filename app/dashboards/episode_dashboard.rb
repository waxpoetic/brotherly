# frozen_string_literal: true

require 'administrate/base_dashboard'

class EpisodeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    performances: Field::HasMany,
    artists: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    eventbrite_url: Field::String,
    facebook_url: Field::String,
    youtube_id: Field::String,
    starts_at: Field::DateTime,
    ends_at: Field::DateTime,
    published_at: Field::DateTime,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    short_link_url: Field::String,
    eventbrite_event_id: Field::Number,
    flyer_file: UploadField,
    video_url: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    name
    starts_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    facebook_url
    eventbrite_url
    youtube_id
    starts_at
    ends_at
    published_at
    description
    video_url
    flyer_file
  ].freeze

  # Overwrite this method to customize how episodes are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(episode)
    episode.name
  end
end
