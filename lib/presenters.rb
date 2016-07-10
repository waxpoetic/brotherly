module Presenters
  extend ActiveSupport::Autoload
  extend ActiveSupport::Concern

  autoload :Presenter
  autoload :CollectionPresenter
  autoload :Presentable
  autoload :Relation
  autoload :Helpers

  def decorate(model, **options)
    model.decorator.new(model, **options)
  end
end

using Presenters::Relation
