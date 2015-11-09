class AddDefaultValueToVotes < ActiveRecord::Migration
  def change
    change_column_default :tabs_sets, :upvotes, 0
    change_column_default :tabs_sets, :downvotes, 0
  end
end
