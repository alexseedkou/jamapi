class AddSongAlbumTrackIdArtWorkUrl < ActiveRecord::Migration
  def change
      change_column_default :songs, :album, ""
      add_column 'songs', 'track_id', :integer, default: 0
      add_column 'songs', 'artwork_url', :string, default: ""
  end
end
