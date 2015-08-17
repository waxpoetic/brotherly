require 'active_model'

class Service
  include ActiveModel::Model

  define_model_callbacks :save, :create, :validation

  extend Enumerable

  attr_accessor :local

  attr_reader :remote

  cattr_accessor :remote_object, :local_name, :attribute_name

  self.attribute_name ||= "#{model_name.param_key}_url".to_sym

  validates :local, presence: true

  def self.each
    Dir["app/services/*_service.rb"].map { |path|
      File.basename(path).classify.constantize
    }.each { |klass|
      yield klass
    }
  end

  def self.create(from_local)
    event = new local: local
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

  def persisted?
    remote.present?
  end

  delegate :url, to: :remote

  delegate :attributes, to: :local

  def method_missing(method, *arguments)
    return super unless respond_to?(method)
    local
  end

  def respond_to?(method)
    self.class.local_name == method || super
  end

  def to_param
    self.class.attribute_name
  end

  private

  def create
    run_callbacks :create do
      @remote = self.class.remote_object.new(attributes)
      @remote.save
    end
  end
end

