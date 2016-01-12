class AddSetScoresToSong < ActiveRecord::Migration
  def change
    add_column 'songs', 'set_scores', :integer, array: true, default: []
  end
end
