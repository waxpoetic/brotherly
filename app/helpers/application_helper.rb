# Helper methods that pertain to the entire application.
module ApplicationHelper
  # Name of the current action.
  #
  # @return [String]
  def page_name
    controller.action_name.to_s
  end

  # Name of the current controller.
  #
  # @return [String]
  def section_name
    controller_name = File.basename(controller.controller_name.to_s)
    return 'users' if controller_name =~ /sessions/
    controller_name
  end

  # Configuration options set in the Rails config.
  #
  # @return [ActiveSupport::OrderedOptions]
  def config
    Rails.configuration
  end

  # The navigation subscribe text in addition to its icon.
  #
  # @return [String::SafeBuffer]
  def subscribe_text
    "#{icon('envelope')} #{t(:subscribe, scope: :nav)}".html_safe
  end

  # Create an +<li>+ and +<a>+ tag fragment that is used in the
  # navigation as a link button.
  #
  # @param [String] text
  # @param [String] href
  # @option [Boolean] modal - +true+ to open in a modal dialog
  def nav_link(text, href, modal: false)
    link_method = modal ? :link_to_modal : :link_to
    content_tag :li, class: [active_link?(href), 'nav-item'].join("\s") do
      send link_method, text, href, class: 'nav-link'
    end
  end

  # Return the year or range of years the copyright in the footer is
  # good for.
  #
  # @return [String]
  def copyright_year
    if Time.zone.now.year == config.founding_year
      Time.zone.now.year.to_s
    else
      "#{config.founding_year} - #{Time.zone.now.year}"
    end
  end

  # Open the link at +href+ in a modal dialog.
  #
  # @param [String] text
  # @param [String] href
  # @param [Hash] options
  # @return [String::SafeBuffer]
  def link_to_modal(text, href, options = {})
    data = options[:data] || {}
    link_to text, href, options.merge(
      data: data.merge(
        'reveal-ajax' => true,
        'reveal-id' => 'dialog'
      )
    )
  end

  # Create an open graph +<meta>+ tag.
  #
  # @return [String::SafeBuffer]
  def og(name, content)
    tag :meta, property: "og:#{name}", content: content
  end

  private

  def active_link?(href)
    'active' if current_page? href
  end
end
