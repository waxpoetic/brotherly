# frozen_string_literal: true
class Search
  # Encapsulates the logic for finding the type of and returning actual
  # records for any given model.
  class Results
    attr_reader :documents, :type

    # @param [Array<PgSearch::Multisearch::Document>] all_documents
    # @param [String] type
    def initialize(all_documents, type)
      @all_documents = all_documents
      @type = type
    end

    # Collection of model objects that are represented by this results
    # object.
    #
    # @return [ActiveRecord::Relation]
    def records
      @records ||= model.where id: ids
    end

    # Model class that the type corresponds to
    #
    # @return [Class]
    def model
      @model ||= type.constantize
    end

    # Collection of IDs used to obtain the model records.
    #
    # @return [Array<Integer>]
    def ids
      @ids ||= documents.map(&:searchable_id)
    end

    # Collection of document records filtered by type.
    #
    # @return [Array<PgSearch::Multisearch::Document>]
    def documents
      @documents ||= @all_documents.select do |document|
        document.searchable_type == type
      end
    end
  end
end
