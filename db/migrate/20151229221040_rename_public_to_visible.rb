class RenamePublicToVisible < ActiveRecord::Migration
  def change
    rename_column("tabs_sets", "public", "visible")
    rename_column("lyrics_sets", "public", "visible")
  end
end
