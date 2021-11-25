class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, index: { unique: true }, foreign_key: true,null: false
      t.references :address, index: { unique: true }, foreign_key: true,null: false
      t.references :product, index: { unique: true }, foreign_key: true,null: false
      t.string :order_no,null:false
      t.integer :amount,null:false
      t.decimal :total_payment, precision: 10, scale: 2,null:false
      t.datetime :payment_at,null:false
      t.timestamps
    end
    add_index :orders, [:order_no], unique: true
  end
end
