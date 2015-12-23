module Admin
  # Perform a search using PgSearch when a query is given.
  module Search
    refine Administrate::Search do
      def run
        return resource_class.all if term.blank?
        resource_class.search term.downcase
      end
    end
  end
end
