require "administrate/fields/base"

class UploadField < Administrate::Field::Base
  def to_s
    data
  end
end
