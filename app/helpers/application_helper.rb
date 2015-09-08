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
      content_for :title
    else
      app_title
    end
  end

  def search_result_path(result)
    send "#{result.searchable_type.parameterize}_path", result.searchable_id
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

  def copyright_year
    if Time.now.year == config.founding_year
      Time.now.year
    else
      "#{config.founding_year} - #{Time.now.year}"
    end
  end

  def link_to_modal(text, href, options = {})
    data = options[:data] || {}
    link_to text, href, options.merge(
      data: data.merge(
        'reveal-ajax' => true,
        'reveal-id' => '#dialog'
      )
    )
  end

  def latest_cache_key(collection_name)
    collection = send collection_name
    latest_update = collection.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "footer/recent_episodes-#{latest_update}"
  end

  def podcast_publish_date
    episodes.last.published_at
  end

  def podcast_cache_key(section = nil)
    last_updated_at = episodes.last.updated_at.try(:utc).try(:to_s, :number) || '0'

    if section
      "podcast/#{last_updated_at}/#{section}"
    else
      "podcast/#{last_updated_at}"
    end
  end

  private

  def active_link?(href)
    'active' if current_page? href
  end

  def app_title
    if controller.controller_name =~ /admin/
      "#{config.name} admin (#{Rails.env})"
    else
      config.name
    end
  end
end
