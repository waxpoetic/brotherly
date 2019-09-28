# frozen_string_literal: true

class InstallPgTrigramContribPackage < ActiveRecord::Migration[5.0]
  def change
    enable_extension :pg_trgm
  end
end
