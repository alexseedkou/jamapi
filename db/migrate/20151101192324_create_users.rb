class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :auth_token
      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
