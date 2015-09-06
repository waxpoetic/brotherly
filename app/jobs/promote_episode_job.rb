class PromoteEpisodeJob < ActiveJob::Base
  queue_as :promotions

  def perform(model)
    Service.each do |service_object|
      service = service_object.create(model)
      model.update service.to_param => service.url if service.persisted?
    end
  end
end
