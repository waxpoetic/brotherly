class ApplicationDecorator < Draper::Decorator
  delegate :t, to: I18n

  # Default title of every show and edit page.
  #
  # @return [String]
  def title
    model.name.titleize
  end

  def placeholder_text
    model.name.gsub(/\s/, '+')
  end
end
