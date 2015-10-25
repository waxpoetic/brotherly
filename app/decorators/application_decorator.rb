class ApplicationDecorator < Draper::Decorator
  def fields
    model.class.column_names.reject do |column|
      column =~ /id|type|created_at|updated_at/
    end
  end
end
