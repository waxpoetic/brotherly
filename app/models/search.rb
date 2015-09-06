# Temporary model object for use with the multi-search system.
class Search
  include ActiveModel::Model

  # Raw search query presented to the engine.
  #
  # @attr_accessor [String]
  attr_accessor :query

  # Collection of results that came back in the query.
  #
  # @attr_accessor [ActiveRecord::Relation]
  attr_reader :results

  validates :query, presence: true

  def self.create(query)
    search = new query: query
    search.save
    search
  end

  def save
    valid? && create
  end

  def persisted?
    results.present?
  end

  private

  def create
    @results = PgSearch.multisearch query
  end
end
