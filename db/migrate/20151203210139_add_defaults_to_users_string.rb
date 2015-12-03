class AddDefaultsToUsersString < ActiveRecord::Migration
  def change
    change_column_default :users, :nickname, ""
    change_column_default :users, :avatar_url_medium, ""
    change_column_default :users, :avatar_url_thumbnail, ""
  end
end
