class AddUserDeliveryDetailId < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :default_address_id, :integer
  end
end
