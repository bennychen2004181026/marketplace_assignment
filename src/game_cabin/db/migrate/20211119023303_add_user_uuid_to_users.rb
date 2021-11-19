class AddUserUuidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_uuid, :string
    add_index :users, :user_uuid
  end
  # To ensure all user records including the older ones, assigning them with an unique uuid
  User.find_each do |user|
    user.uuid = SecureRandom.base36(24)
    user.save
  end
end
