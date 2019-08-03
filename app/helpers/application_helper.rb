# frozen_string_literal: true

# Helper methods that pertain to the entire application.
module ApplicationHelper
  def nav_link_to(name, route = nil)
    label = t(name, scope: %i[titles pages])
    route ||= send "#{name}_path"

    link_to label, route, class: active_class_for(route)
  end

  def home_page_slideshow_settings(_current_episodes)
    {
      autoplay: false # current_episodes.empty?
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

  # Return the year or range of years the copyright in the footer is
  # good for.
  #
  # @return [String]
  def copyright_year
    return current_year.to_s if current_year == config.founding_year

    "#{config.founding_year} - #{current_year}"
  end

  private

  def active_class_for(route)
    'active' if current_page?(route)
  end

  def current_year
    Time.zone.now.year
  end
end
