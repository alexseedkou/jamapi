class AddPreviewAndiTunesLink < ActiveRecord::Migration
  def change
    add_column 'songs', 'preview_url', :string, default: ""
    add_column 'songs', 'store_link', :string, default: ""
  end
end
