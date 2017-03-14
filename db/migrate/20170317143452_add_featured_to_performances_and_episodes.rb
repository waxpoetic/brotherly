class AddFeaturedToPerformancesAndEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :performances, :featured, :boolean
    add_column :episodes, :featured, :boolean
  end
end
