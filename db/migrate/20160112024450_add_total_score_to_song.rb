class AddTotalScoreToSong < ActiveRecord::Migration
  def change
    add_column 'songs', 'total_score', :integer, :default => 0
  end
end
