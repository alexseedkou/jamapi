class AddCachedVotesToLyricsSets < ActiveRecord::Migration
  def self.up
    #remove old columns
   remove_column :lyrics_sets, :upvotes if LyricsSet.column_names.include?('upvotes')
   remove_column :lyrics_sets, :downvotes if LyricsSet.column_names.include?('downvotes')

   add_column :lyrics_sets, :cached_votes_total, :integer, :default => 0
   add_column :lyrics_sets, :cached_votes_score, :integer, :default => 0
   add_column :lyrics_sets, :cached_votes_up, :integer, :default => 0
   add_column :lyrics_sets, :cached_votes_down, :integer, :default => 0
   add_column :lyrics_sets, :cached_weighted_score, :integer, :default => 0
   add_column :lyrics_sets, :cached_weighted_total, :integer, :default => 0
   add_column :lyrics_sets, :cached_weighted_average, :float, :default => 0.0
   add_index  :lyrics_sets, :cached_votes_total
   add_index  :lyrics_sets, :cached_votes_score
   add_index  :lyrics_sets, :cached_votes_up
   add_index  :lyrics_sets, :cached_votes_down
   add_index  :lyrics_sets, :cached_weighted_score
   add_index  :lyrics_sets, :cached_weighted_total
   add_index  :lyrics_sets, :cached_weighted_average

   # Uncomment this line to force caching of existing votes
   # Post.find_each(&:update_cached_votes)
 end

 def self.down
   remove_column :lyrics_sets, :cached_votes_total
   remove_column :lyrics_sets, :cached_votes_score
   remove_column :lyrics_sets, :cached_votes_up
   remove_column :lyrics_sets, :cached_votes_down
   remove_column :lyrics_sets, :cached_weighted_score
   remove_column :lyrics_sets, :cached_weighted_total
   remove_column :lyrics_sets, :cached_weighted_average
 end
end
