ActiveRecord::Base.send :include, ActiveModel::Jobs

ActiveRecord::Base.class_eval do
  def sort_and_paginate(current, total)
    order('updated_at DESC').page(current).per(total)
  end
end
