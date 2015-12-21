require "administrate/fields/base"

class HstoreField < Administrate::Field::Base
  def to_s
    data
  end
end
