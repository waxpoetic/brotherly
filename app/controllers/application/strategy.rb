require 'decent_exposure/strong_parameters_strategy'

module Application
  # A strategy for DecentExposure that automatically authorizes the
  # resource and decorates it with a presenter object.
  class Strategy < DecentExposure::StrongParametersStrategy
    delegate :current_page, :per_page, to: :controller

    # Generate a policy scope for all collection resources, then
    # decorate the finished object relation.
    def collection_resource
      collection_presenter.new(
        super.page(current_page).per(per_page),
        with: presenter
      )
    end

    def singular_resource
      presenter.new super
    end

    private

    def presenter
      "#{model.model_name.name}Presenter".constantize
    end

    def collection_presenter
      "#{model.model_name.plural.capitalize}Presenter".constantize
    end

    def model
      controller.model_name.to_s.classify.constantize
    end
  end
end
