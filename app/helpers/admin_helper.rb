module AdminHelper
  def link_to_destroy text, model, size: 'tiny', title: nil
    link_to(
      text,
      [:admin, model],
      method: :delete,
      remote: true,
      title: title,
      class: "#{size} destroy alert button"
    )
  end

  def association(field)
    field.keys.first.to_s.gsub(/_attributes/, '').pluralize.to_sym
  end

  def model_name
    controller.model_name
  end

  def edit_path *args
    public_send "edit_admin_#{model_name}_path", *args
  end

  def new_path
    public_send "new_admin_#{model_name}_path"
  end

  def model_class
    model_name.to_s.classify.constantize
  end

  def fields_cache_key
    "#{collection_name}/fields/#{model_class.schema_last_updated_at}"
  end

  def models
    root = Rails.root.join('app', 'models')
    Dir["#{root.to_s}/*.rb"].map do |path|
      path.gsub(/#{root}|\.rb/, '').classify.constantize
    end.select do |klass|
      klass.ancestors.include? ActiveRecord::Base
    end.sort { |l,n| l.name <=> n.name }
  end

  def admin_nav_item(table, href = nil)
    href ||= url_for table
    nav_link t(table, scope: 'layouts.admin.navigation'), [:admin, href]
  end

  def nav_item(table, href = nil)
    href ||= url_for table
    nav_link t(table, scope: 'layouts.admin.navigation'), href
  end

  private

  def active?(href)
    'active' if current_page? href
  end
end
