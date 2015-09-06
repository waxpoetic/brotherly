class SearchSerializer < ActiveModel::Serializer
  has_many :results, serializer: SearchResultSerializer
end
