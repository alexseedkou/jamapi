class RemoveFirstAddedDate < ActiveRecord::Migration
  def change
    remove_column 'songs', 'first_tabs_added_at'
  end
end
