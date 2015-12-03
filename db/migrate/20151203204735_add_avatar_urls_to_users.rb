class AddAvatarUrlsToUsers < ActiveRecord::Migration
  def up
     add_column :users, :avatar_url_medium, :string
     add_column :users, :avatar_url_thumbnail, :string
  end

  def down
    remove_column :users, :avatar_url_medium, :string
    remove_column :users, :avatar_url_thumbnail, :string
  end
end
