class ApplicationPresenter < Makeover::Presenter
  delegate :t, :translate, to: I18n

  class << self
    def model_class
      name.gsub(/Presenter/, '').constantize
    end

    delegate :model_name, to: :model_class
  end

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
