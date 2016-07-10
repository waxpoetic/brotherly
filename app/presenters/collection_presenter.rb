class CollectionPresenter < Presenters::CollectionPresenter
  def fields
    object.column_names.select do |column|
      column =~ /\A(name|type|created_at|updated_at)\Z/
    end
  end

  def name
    object.model_name.route_key
  end
end
