class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :remote, type: :string, required: true
  argument :local, type: :string, required: true

  def copy_promoter
    template 'promoter.rb.erb', "app/promoters/#{file_name}_promoter.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/promoters/#{file_name}_promoter_spec.rb"
  end
end
