class AddDefaultTolyricsVotes < ActiveRecord::Migration
  def change
    change_column_default :lyrics_sets, :upvotes, 0
    change_column_default :lyrics_sets, :downvotes, 0
  end
end
