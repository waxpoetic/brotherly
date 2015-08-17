module TitleHelper
  def title(new_title)
    content_for :title, new_title
  end

  def page_title
    if content_for? :title
      yield :title
    else
      config.title
    end
  end

  def title_tag
    content_tag :title, if page_title == config.title
      config.title
    else
      "#{page_title} | #{config.title}"
    end
  end

  private

  def config
    Rails.application.config
  end
end
