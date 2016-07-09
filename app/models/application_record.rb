require 'refile/attachment/active_record'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Refile::ActiveRecord::Attachment
  include Searchable
end
