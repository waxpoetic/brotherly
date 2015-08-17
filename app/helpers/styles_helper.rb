module StylesHelper
  def page_name
    controller.action_name.to_s
  end

  def section_name
    File.basename(controller.controller_name.to_s)
  end
end
