class CollectionDecorator < Draper::CollectionDecorator
  delegate_all!

  def fields
    model.column_names.select do |column|
      column =~ /name|type|created_at|updated_at/
    end
  end
end
