class PresenterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_presenter
    template 'presenter.rb.erb', "app/presenters/#{file_name}_presenter.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/presenters/#{file_name}_presenter_spec.rb"
  end
end
