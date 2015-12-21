require "administrate/base_dashboard"

class EpisodeDashboard < Administrate::BaseDashboard
  READ_ONLY_ATTRIBUTES = [
    :id,
    :created_at,
    :updated_at,
  ]

  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    performances: Field::HasMany,
    artists: Field::HasMany,
    # pg_search_document: Field::HasOne,
    # id: Field::Number,
    name: Field::String,
    eventbrite_url: Field::String,
    youtube_url: Field::String,
    mixcloud_url: Field::String,
    facebook_url: Field::String,
    starts_at: Field::DateTime,
    ends_at: Field::DateTime,
    published_at: Field::DateTime,
    description: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    slug: Field::String,
    short_url: Field::String,
    preview_image_id: Field::String,
    eventbrite_event_id: Field::Number,
    audio_file_id: Field::String,
    flyer_file_id: Field::String,
  }

  # TABLE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to remove the limit or customize the returned array.
  TABLE_ATTRIBUTES = ATTRIBUTE_TYPES.keys.first(4)

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = ATTRIBUTE_TYPES.keys - READ_ONLY_ATTRIBUTES
end
