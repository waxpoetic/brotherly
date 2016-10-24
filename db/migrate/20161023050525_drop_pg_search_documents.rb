# frozen_string_literal: true
class DropPgSearchDocuments < ActiveRecord::Migration[5.0]
  def change
    drop_table :pg_search_documents
  end
end
