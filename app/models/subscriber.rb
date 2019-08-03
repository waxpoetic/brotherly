# frozen_string_literal: true

class Subscriber < ApplicationRecord
  validates :email, presence: true, email: true

  after_create :add!
end
