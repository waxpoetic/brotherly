# Performs a multi-search against all of the models included within the
# pg_search multisearch index. Wraps the +PgSearch.multisearch+ call and
# presents its results as a series of +ActiveRecord+ models rather than
# the raw document objects returned by the search query.
class Search
  include ActiveModel::Model
  include Makeover::Presentable

  # Raw search query presented to the engine.
  #
  # @attr_accessor [String]
  attr_accessor :query

  # A collection of documents that are returned after performing the
  # search query
  #
  # @attr_reader [Array<PgSearch::Multisearch::Document>]
  attr_reader :documents

  validates :query, presence: true

  def initialize(params = {})
    @documents = []
    super
  end

  # Perform a new search with the given query
  #
  # @param [String] query
  # @return [Search]
  def self.create(query)
    search = new query: query
    search.save
    search
  end

  # Validate the query given and perform the multisearch with
  # +PgSearch+ if valid.
  #
  # @return [Boolean] +true+ if the search was performed
  def save
    valid? && create
  end

  # Collection of results that came back in the query.
  #
  # @return [Array<ActiveRecord::Base>]
  def results
    models.map do |model|
      Results.new(documents, model).records
    end.flatten.uniq
  end

  private

  # @private
  # @return [Boolean]
  def create
    @documents = PgSearch.multisearch(query) || []
    true
  end

  # @private
  # @return [Array<Class>]
  def models
    documents.map(&:searchable_type)
  end
end
