# frozen_string_literal: true
#
# Configure PgSearch multi-search options
#
PgSearch.multisearch_options = {
  using: Rails.application.config.search
}
