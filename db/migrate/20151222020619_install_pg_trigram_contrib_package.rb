# frozen_string_literal: true

class InstallPgTrigramContribPackage < ActiveRecord::Migration
  def change
    enable_extension :pg_trgm
  end
end
