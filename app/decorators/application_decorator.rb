class ApplicationDecorator < Draper::Decorator
  # Default title of every show and edit page.
  #
  # @return [String]
  def title
    model.name.titleize
  end
end
