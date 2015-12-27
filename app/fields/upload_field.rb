require 'administrate/fields/base'

class UploadField < Administrate::Field::Base
  def attribute
    super.to_s.gsub(/_id/, '').to_sym
  end

  def to_s
    data
  end

  def url(model)
    Refile.attachment_url model, attribute
  end
end
