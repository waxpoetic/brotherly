#
# Configure PgSearch multi-search options
#
PgSearch.multisearch_options = {
  using: {
    tsearch: {
      prefix: true,
      any_word: true
    },
    trigram: true
  }
}
