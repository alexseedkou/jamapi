class AddCachedVotesToTabsSets < ActiveRecord::Migration
  def self.up
    #remove old columns
    remove_column :tabs_sets, :upvotes if TabsSet.column_names.include?('upvotes')
    remove_column :tabs_sets, :downvotes if TabsSet.column_names.include?('downvotes')

   add_column :tabs_sets, :cached_votes_total, :integer, :default => 0
   add_column :tabs_sets, :cached_votes_score, :integer, :default => 0
   add_column :tabs_sets, :cached_votes_up, :integer, :default => 0
   add_column :tabs_sets, :cached_votes_down, :integer, :default => 0
   add_column :tabs_sets, :cached_weighted_score, :integer, :default => 0
   add_column :tabs_sets, :cached_weighted_total, :integer, :default => 0
   add_column :tabs_sets, :cached_weighted_average, :float, :default => 0.0
   add_index  :tabs_sets, :cached_votes_total
   add_index  :tabs_sets, :cached_votes_score
   add_index  :tabs_sets, :cached_votes_up
   add_index  :tabs_sets, :cached_votes_down
   add_index  :tabs_sets, :cached_weighted_score
   add_index  :tabs_sets, :cached_weighted_total
   add_index  :tabs_sets, :cached_weighted_average

   # Uncomment this line to force caching of existing votes
   # Post.find_each(&:update_cached_votes)
 end

 def self.down
   remove_column :tabs_sets, :cached_votes_total
   remove_column :tabs_sets, :cached_votes_score
   remove_column :tabs_sets, :cached_votes_up
   remove_column :tabs_sets, :cached_votes_down
   remove_column :tabs_sets, :cached_weighted_score
   remove_column :tabs_sets, :cached_weighted_total
   remove_column :tabs_sets, :cached_weighted_average
 end
end
