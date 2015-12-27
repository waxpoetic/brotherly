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
    youtube_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    audio_file: UploadField,
    video_file: UploadField
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :episode,
    :artist
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :artist,
    :episode,
    :starts_at,
    :ends_at,
    :youtube_id,
    :audio_file,
    :video_file
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :artist,
    :episode,
    :starts_at,
    :ends_at,
    :audio_file,
    :video_file
  ]

  # Overwrite this method to customize how performances are displayed
  # across all pages of the admin dashboard.
  def display_resource(performance)
    "#{performance.artist.name} at #{performance.episode.name}"
  end
end
