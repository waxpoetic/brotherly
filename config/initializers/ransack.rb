Ransack::Adapters::ActiveRecord::Base.class_eval do
  remove_method :search
end
