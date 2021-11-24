class AddUserDeliveryDetailId < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :delivery_detail_id, :integer
  end
end
