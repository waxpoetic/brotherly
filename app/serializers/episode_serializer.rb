class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :facebook_url, :starts_at, :ends_at,
             :slug, :audio_file_url, :flyer_file_url, :short_link_url,
             :video_url, :featured

  def ticket_url
    object.eventbrite_url
  end
end

# == Schema Information
#
# Table name: episodes
#
#  id                  :integer          not null, primary key
#  name                :string
#  eventbrite_url      :string
#  mixcloud_url        :string
#  facebook_url        :string
#  starts_at           :datetime
#  ends_at             :datetime
#  published_at        :datetime
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  slug                :string
#  eventbrite_event_id :string
#  audio_file_id       :string
#  flyer_file_id       :string
#  youtube_id          :string
#  audio_transcoded_at :datetime
#  short_link_url      :string
#  video_url           :string
#  featured            :boolean
#
