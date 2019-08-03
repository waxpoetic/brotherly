# frozen_string_literal: true

# Allows for uploading audio and video files to records in the database.
# Used mainly on +Episode+ and +Performance+, this module also
# automatically kicks off transcode jobs in AWS after video is uploaded.
module Media
  extend ActiveSupport::Concern

  AUDIO_EXTENSIONS = %w[mp3 wav].freeze

  included do
    attachment :audio_file
  end

  def playlist_name
    name.parameterize
  end
end
