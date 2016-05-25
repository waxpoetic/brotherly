require 'administrate/field/base'

class UploadField < Administrate::Field::Base
  # def attribute
  #   super.to_s.gsub(/_id/, '').to_sym
  # end

  def to_s
    data
  end
end
