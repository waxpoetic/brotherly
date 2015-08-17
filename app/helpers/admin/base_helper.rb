module Admin::BaseHelper
  def nav_link(text, href, *args)
    content_tag :li, class: active_link?(href) do
      link_to text, href, *args
    end
  end

  private

  def active_link?(href)
    'active' if current_page? href
  end
end
