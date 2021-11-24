class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street_address,null: false
      t.string :suburb,null: false
      t.string :state,null: false
      t.integer :postcode,null: false
      t.timestamps
    end
    add_index :addresses, [:street_address]
    add_index :addresses, [:suburb]
    add_index :addresses, [:state]
    add_index :addresses, [:postcode]
  end
end
