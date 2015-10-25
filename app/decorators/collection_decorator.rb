class CollectionDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :total_count,
           :entry_name, :offset_value, :last_page?, :table_name

  def fields
    model.column_names.select do |column|
      column =~ /name|type|created_at|updated_at/
    end
  end
end
