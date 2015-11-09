# Standardized searching for any model class that wishes to implement
# it. This module implements the +.search+ method on your model, which
# takes a String query and uses +PgSearch+ (and the PostgreSQL TSEARCH
# functionality) to perform a full-text search on any attributes given
# in the +searchable+ macro.
module Searchable
  extend ActiveSupport::Concern

  included do
    include PgSearch
    class_attribute :pg_search_attributes
  end

  class_methods do
    def searchable(*arguments)
      self.pg_search_attributes = arguments
      pg_search_scope :search, pg_search_options
    end

    private

    def pg_search_options
      {
        attributes: pg_search_attributes,
        types: pg_search_types
      }
    end

    def pg_search_types
      { tsearch: { prefix: true } }
    end
  end
end
