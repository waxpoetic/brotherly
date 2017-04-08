# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Makeover::Presentable

  # Model classes that can be seeded. Pre-loads model files before
  # calling +ApplicationRecord.subclasses+..
  #
  # @return [Array<Class>]
  def self.seeds
    subclasses.reject { |model| model.name =~ /User|Subscriber/ }
  end
end
