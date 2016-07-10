module Draper
  module Relation
    refine ActiveRecord::Relation do
      def decorator
        if to_sql =~ /FROM "(.*)"/
          "#{$1.camelize}Decorator".constantize
        end
      end
    end
  end
end
