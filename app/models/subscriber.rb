class Subscriber < ActiveRecord::Base
  include Searchable

  searchable name: 'A', email: 'B'

  validates :email, presence: true, email: true

  after_create :add!
end
