require 'active_model'

module Brotherly
  # A true "Service object", this communicates with an outside service
  # (like a social network) to either promote a given future or current
  # episode, or in the case of the +EventbriteService+, to actually
  # create and schedule the event to prepare for ticket sales.
  class Service
    include ActiveModel::Model

    define_model_callbacks :save, :create, :validation

    extend Enumerable

    attr_accessor :local

    class_attribute :remote_object
    class_attribute :local_name
    class_attribute :attribute_name

    validates :local, presence: true
    validates :remote, presence: true

    delegate :url, :persisted?, to: :remote
    delegate :attributes, to: :local, allow_nil: true

    alias_method :to_param, :attribute_name

    def self.default_attribute_name
      "#{model_name.param_key}_url".gsub(/brotherly_/, '').to_sym
    end

    self.attribute_name ||= default_attribute_name

    def self.each
      Dir["app/services/*_service.rb"].map { |path|
        File.basename(path).gsub(/\.rb/, '').classify.constantize
      }.each { |klass|
        yield klass
      }
    end

    def self.create(from_local)
      event = new local: from_local
      event.save
      event
    end

    def self.remote(klass)
      self.remote_object = klass
    end

    def self.local(name)
      self.local_name = name
    end

    def self.param(name)
      self.attribute_name = name
    end

    def save
      run_callbacks :save do
        valid? && create
      end
    end

    def method_missing(method, *arguments)
      return super unless respond_to?(method)
      local
    end

    def respond_to?(method, *args)
      local_name == method || super
    end

    def to_h
      { to_param => url }
    end

    private

    def remote
      @remote ||= remote_object.new(attributes)
    end

    def create
      run_callbacks :create do
        remote.save
      end
    end
  end
end
