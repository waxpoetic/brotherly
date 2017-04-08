class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :links, :image_file_url
end

# == Schema Information
#
# Table name: artists
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  slug          :string
#  links         :hstore
#  description   :text
#  image_file_id :string
#
