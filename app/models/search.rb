# Temporary model object for use with the multi-search system.
class Search
  include ActiveModel::Model
  include Draper::Decoratable

  # Raw search query presented to the engine.
  #
  # @attr_accessor [String]
  attr_accessor :query

  # Collection of results that came back in the query.
  #
  # @attr_accessor [ActiveRecord::Relation]
  def results
    @results.map(&:searchable_type).map do |type|
      ids = @results.select { |r| r.searchable_type == type }.map(&:searchable_id)
      type.constantize.where id: ids
    end.flatten
  end

  validates :query, presence: true

  def initialize(params = {})
    @results = []
    super
  end

  def self.create(query)
    search = new query: query
    search.save
    search
  end

  def save
    valid? && create
  end

  private

  def create
    @results = PgSearch.multisearch(query) || []
  end
end
