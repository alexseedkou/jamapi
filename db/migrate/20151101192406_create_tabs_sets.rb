class CreateTabsSets < ActiveRecord::Migration
  def change
    create_table :tabs_sets do |t|
      t.string :tuning
      t.integer :capo
      t.string :times, array: true
      t.string :chords, array: true
      t.string :tabs, array: true
      t.integer :upvotes
      t.integer :downvotes
      t.references :song, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
      t.integer :song_id
    end
    add_index("tab_sets", "song_id")
  end
end
