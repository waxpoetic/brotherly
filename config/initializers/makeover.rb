# frozen_string_literal: true

require 'makeover'

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.send :include, Makeover::Presentable
end
