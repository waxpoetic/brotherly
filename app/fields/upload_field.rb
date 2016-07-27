require 'administrate/field/base'

class UploadField < Administrate::Field::Base
  def filename
    data.try :filename
  end

  def url
    data.try :url
  end
end
