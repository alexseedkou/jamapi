class AddPublicToSet < ActiveRecord::Migration
  def change
    add_column 'tabs_sets', 'public', :boolean
    add_column 'lyrics_sets', 'public', :boolean
  end
end
