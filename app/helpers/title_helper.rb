# Helper methods for controlling and showing the current title of the
# application in the +<title>+ tag.
module TitleHelper
  # Modify the title of the application on a per-page level.
  #
  # @param [String] new_title
  def title(new_title)
    content_for :title, new_title
  end


  # Title tag of the application including the current title.
  #
  # @return [String::SafeBuffer] the +<title>+ tag.
  def title_tag
    content_tag :title, current_title
  end

  # Current title of the application, separated by '|' if a title exists
  # or just showing the app title otherwise.
  #
  # @return [String]
  def current_title
    if content_for? :title
      [page_title, app_title].uniq.join(' | ')
    else
      app_title
    end
  end

  private

  # Return the app title, and suffix with 'admin' if the controller
  # is in the admin.
  #
  # @private
  # @return [String]
  def app_title
    if admin?
      "#{Rails.configuration.name} admin (#{Rails.env})"
    else
      Rails.configuration.name
    end
  end

  # Return the current page title.
  #
  # @private
  # @return [String]
  def page_title
    content_for :title
  end

  def admin?
    request.original_fullpath =~ /admin/
  end
end
