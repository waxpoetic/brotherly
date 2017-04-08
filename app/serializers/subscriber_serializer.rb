class SubscriberSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
end

# == Schema Information
#
# Table name: subscribers
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
