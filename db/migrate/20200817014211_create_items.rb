class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,               null: false
      t.text   :explanation,        null: false
      t.string :price,              null: false
      t.references :user,           foreign_key: true
      t.string :first_name,         null: false
      t.string :last_name_kana,     null: false
      t.string :first_name_kana,    null: false

      t.timestamps
    end
  end
end
