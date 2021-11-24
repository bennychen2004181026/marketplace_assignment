class CreateDeliveryDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_details do |t|
      t.integer :user_id,null: false
      t.string :address_type,null: false
      t.string :contact_name,null: false
      t.string :phone,null: false
      t.references :address_id,null: false, foreign_key: true
      t.timestamps
    end
    add_index :delivery_details, [:user_id, :address_type]
    add_index :delivery_details, [:address_id]
  end
end