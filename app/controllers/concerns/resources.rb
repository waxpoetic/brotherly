module Resources
  extend ActiveSupport::Concern

  included do
    class_attribute :resource_name
    class_attribute :collection_actions
    self.collection_actions ||= %w(index)
  end

  class_methods do
    def resource(name)
      self.resource_name = name
      before_action :find_resource
    end
  end

  protected

  def find_resource
    if collection_action?
      instance_variable_set "@#{collection_name}", collection
    else
      instance_variable_set "@#{model_name}", model
    end
  end

  private

  def model
    model_class.find params[:id]
  end

  def collection
    model_class.where params.permit!
  end

  def collection_action?
    collection_actions.include? action_name.to_sym
  end

  def model_class
    @model_class ||= model_name.constantize
  end

  def model_name
    @model_name ||= resource_name.to_s.camelize
  end
end
