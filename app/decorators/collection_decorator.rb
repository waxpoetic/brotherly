class CollectionDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :total_count,
           :entry_name, :offset_value, :last_page?, :table_name, :new,
           :friendly, :build, :create, :where, :order

  delegate :find, to: :friendly

  def fields
    object.column_names.select do |column|
      column =~ /\A(name|type|created_at|updated_at)\Z/
    end
  end

  def name
    object.model_name.route_key
  end
end
