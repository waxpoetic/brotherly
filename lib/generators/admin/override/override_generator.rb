class Admin::OverrideGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_view
    copy_file(
      "#{Rails.root}/app/views/admin/#{view_name}.html.haml",
      view_file_path
    )
    extend_collection if view_name == 'index'
    extend_model
  end

  def create_partials
    partials.each do |partial|
      copy_partial partial
      extend_partial partial
    end
  end

  private

  def partials
    case view_name
    when /new|edit/
      %w(form fields controls)
    when /show/
      %w(details)
    else
      []
    end
  end

  private

  def copy_partial(partial)
    copy_file(
      "#{Rails.root}/app/views/admin/_#{partial}.html.haml",
      "app/views/admin/#{controller_name}/_#{partial}.html.haml"
    )
  end

  def extend_partial(partial)
    gsub_file(
      "app/views/admin/#{controller_name}/_#{partial}.html.haml",
      'model',
      resource_name
    )
  end

  def extend_model
    gsub_file(
      view_file_path,
      'model',
      resource_name
    )
  end

  def extend_collection
    gsub_file(
      view_file_path,
      'collection',
      controller_name
    )
  end

  def view_file_path
    "app/views/admin/#{name}.html.haml"
  end

  def resource_name
    controller_name.singularize
  end

  def split_file_name
    name.split '/'
  end

  def controller_name
    split_file_name.first
  end

  def view_name
    split_file_name.last
  end
end
