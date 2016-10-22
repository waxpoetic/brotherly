# frozen_string_literal: true
class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :remote, type: :string, required: true
  argument :local, type: :string, required: true

  def copy_service
    template 'service.rb.erb', "app/services/#{file_name}_service.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/services/#{file_name}_service_spec.rb"
  end
end
