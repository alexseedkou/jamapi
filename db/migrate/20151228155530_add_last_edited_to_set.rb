class AddLastEditedToSet < ActiveRecord::Migration
  def change
      add_column 'tabs_sets', 'last_edited', :datetime
      add_column 'lyrics_sets', 'last_edited', :datetime
  end
end
