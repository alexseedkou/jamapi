class CreateLyricsSets < ActiveRecord::Migration
  def change
    create_table :lyrics_sets do |t|
      t.string :times, array: true
      t.string :lyrics, array: true
      t.integer :upvotes
      t.integer :downvotes
      t.references :song, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
