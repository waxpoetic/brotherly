require 'refile/attachment/active_record'

# Base class for all models.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Searchable

  extend Refile::ActiveRecord::Attachment
end
