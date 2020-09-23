class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_name, null: false
      t.string :event_text, null: false
      t.string :prefecture, null: false
      t.string :city,       null: false
      t.string :block,      null: false
      t.string :building
      t.string :phone,      null: false
      t.datetime :date,     null: false
      t.references :admin,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
