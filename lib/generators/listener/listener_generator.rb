class ListenerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_listener
    template 'listener.rb.erb', "app/listeners/#{file_name}_listener.rb"
    template 'spec.rb.erb', "spec/listeners/#{file_name}_listener_spec.rb"
  end
end
