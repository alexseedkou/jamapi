class AddiniTunesToSong < ActiveRecord::Migration
  def change
    add_column 'songs', 'in_iTunes', :boolean,  default: false
  end
end
