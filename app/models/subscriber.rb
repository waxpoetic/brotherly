# frozen_string_literal: true
class Subscriber < ApplicationRecord
  include Searchable

  searchable :name, :email

  validates :email, presence: true, email: true

  after_create :add!
end
