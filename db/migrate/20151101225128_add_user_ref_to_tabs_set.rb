class AddUserRefToTabsSet < ActiveRecord::Migration
  def change
    remove_reference("tabs_sets","user")
    add_reference :tabs_sets, :user, index: true, foreign_key: true
  end
end
