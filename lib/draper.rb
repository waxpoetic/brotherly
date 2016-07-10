module Draper
  extend ActiveSupport::Autoload
  extend ActiveSupport::Concern

  autoload :Decorator
  autoload :CollectionDecorator
  autoload :Decoratable
  autoload :Relation
  autoload :Helpers

  def decorate(model, **options)
    model.decorator.new(model, **options)
  end
end

use Draper::Relation
