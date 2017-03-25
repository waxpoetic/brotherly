# frozen_string_literal: true
# Helper methods that pertain to the entire application.
module ApplicationHelper
  def nav_link_to(name, route=nil)
    label = t(name, scope: [:titles, :pages])
    route ||= send "#{name}_path"

    link_to label, route, class: active_class_for(route)
  end

  def active_class_for(route)
    'active' if current_page?(route)
  end

  def home_page_slideshow_settings
    {
      autoplay: @current_episodes.empty?
    }.to_json
  end

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
    return current_year.to_s if current_year == config.founding_year
    "#{config.founding_year} - #{current_year}"
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

  def current_year
    Time.zone.now.year
  end
end
