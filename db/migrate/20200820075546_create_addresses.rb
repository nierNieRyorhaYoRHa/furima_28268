class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :purchase,                null: false,  foreign_key: true
      t.string :postal_code,    default: "", null: false
      t.integer :area_id,                    null: false
      t.string :city,           default: "", null: false
      t.string :house_number,   default: "", null: false
      t.string :building_name,  default: ""
      t.string :phone_number,   default: "", null: false
      t.timestamps
    end
  end
end
