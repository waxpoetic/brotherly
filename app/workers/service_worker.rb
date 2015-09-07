# Iterate through all service objects and update the model with their
# given data.
class ServiceWorker < Brotherly::Worker
  def perform
    Brotherly::Service.map { |service|
      service.create model
    }.select(&:persisted?).each { |service|
      model.update service.to_param => service.url
    }
  end
end
