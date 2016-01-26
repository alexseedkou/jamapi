class AddTitleAndArtistAliasToSong < ActiveRecord::Migration
  def change
    add_column 'songs', 'title_aliases', :string,  default: ""
    add_column 'songs', 'artist_aliases', :string, default: ""
  end
end
