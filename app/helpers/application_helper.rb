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

  private

  def app_title
    if controller.controller_name =~ /admin/
      "admin (#{Rails.env})"
    else
      config.title
    end
  end
end
