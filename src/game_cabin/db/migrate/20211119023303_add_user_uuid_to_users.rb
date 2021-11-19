class AddUserUuidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_uuid, :string
    add_index :users, :user_uuid
  end
 
end
