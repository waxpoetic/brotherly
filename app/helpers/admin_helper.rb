module AdminHelper
  def link_to_modal text_or_href, href_or_options, html_options = {}, &block
    data = {
      'reveal-ajax' => true,
      'reveal-id' => 'dialog'
    }
    options = if block_given?
                html_options.merge data: data
              else
                href_or_options.merge data: data
              end
    if block_given?
      link_to text_or_href, options, &block
    else
      link_to text_or_href, href_or_options, options
    end
  end

  def link_to_destroy text, model, size: 'tiny'
    link_to(
      text,
      [:admin, model],
      method: :delete,
      remote: true,
      class: "#{size} destroy button"
    )
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

  def fields
    model_class.column_names.reject do |column|
      column.to_s =~ /id/
    end
  end

  def fields_cache_key
    "#{collection_name}/fields/#{model_class.schema_last_updated_at}"
  end

  def models
    Module.constants.map do |constant_name|
      eval constant_name
    end.select do |constant|
      constant.try :extend?, ActiveRecord::Base
    end
  end

  def nav_item(table, href = nil)
    href ||= url_for table
    nav_link t(table, scope: 'layouts.admin.navigation'), href
  end

  def nav_link(text, href, dropdown: false, &block)
    css = [
      ('active' if current_page? href),
      ('has-dropdown' if block_given?)
    ].compact.join("\s")

    if block_given?
      content_tag :li, class: css, title: text, &block
    else
      content_tag :li, class: css, title: text do
        link_to text, href
      end
    end
  end

  private

  def active?(href)
    'active' if current_page? href
  end
end
