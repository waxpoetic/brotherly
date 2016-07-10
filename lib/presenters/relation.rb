module Presenters
  module Relation
    refine ActiveRecord::Relation do
      def decorator
        if to_sql =~ /FROM "(.*)"/
          "#{$1.camelize}Presenter".constantize
        end
      end
    end
  end
end
