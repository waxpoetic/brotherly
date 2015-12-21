ActiveSupport.on_load :active_record do
  ActiveRecord::Base.class_eval do
    def to_s
      return super unless respond_to? :name
      name
    end
  end
end
