class AddNewTabsAddedDateToSong < ActiveRecord::Migration
  def change
    add_column 'songs', 'first_tabs_added_at', :datetime
  end
end
