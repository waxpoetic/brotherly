module ApplicationHelper
  def page_name
    controller.action_name.to_s
  end

  def section_name
    File.basename(controller.controller_name.to_s)
  end

  def title(new_title)
    content_for :title, new_title
  end

  def page_title
    if content_for? :title
      yield :title
    else
      app_title
    end
  end

  def title_tag
    content_tag :title, [page_title, app_title].uniq.join(" | ")
  end

  def config
    Rails.application.config
  end

  def nav_link(text, href, *args)
    content_tag :li, class: active_link?(href) do
      link_to text, href, *args
    end
  end

  private

  def active_link?(href)
    'active' if current_page? href
  end

  def app_title
    if controller.controller_name =~ /admin/
      "#{config.title} admin (#{Rails.env})"
    else
      config.title
    end
  end
end
