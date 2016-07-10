module Presenters
  extend ActiveSupport::Autoload
  extend ActiveSupport::Concern

  autoload :Presenter
  autoload :CollectionPresenter
  autoload :Presentable
  autoload :Relation
  autoload :Helpers

  def present(model, **options)
    model.present.new(model, **options)
  end
end

using Presenters::Relation
