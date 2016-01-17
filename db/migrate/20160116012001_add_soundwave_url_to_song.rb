class AddSoundwaveUrlToSong < ActiveRecord::Migration
  def change
    add_column 'songs', 'soundwave_url', :string,  default: ""
  end
end
