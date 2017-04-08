module Brotherly
  # Seed data for the application from the production API.
  class Seed
    MODELS = [Artist, Episode, Performance]

    def initialize(model)
      @model = model
      @collection = @model.table_name
      @resource = "/#{@collection}.json"
    end

    def self.each
      MODELS.each do |model_name|
        yield new(model)
      end
    end

    def clear!
      @model.destroy_all!
    end

    def data
      @data ||= response.body[@collection]
    end

    def response
      @response ||= client.get @resource
    end

    private

    # HTTP API client that connects to the production database.
    #
    # @return [Brotherly::Client]
    def client
      @client ||= Client.connect Brotherly::PRODUCTION_DOMAIN_NAME
    end
  end
end
