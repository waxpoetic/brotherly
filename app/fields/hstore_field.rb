require 'administrate/field/base'

class HstoreField < Administrate::Field::Base
  def data
    super || {}
  end

  def to_s
    data
  end
end
