class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :shop_name,             null: false
      t.integer :employment_status_id, null: false
      t.string :work_name,             null: false
      t.string :work_text,             null: false
      t.string :phone,                 null: false
      t.references :admin,             null: false, foreign_key: true
      t.timestamps
    end
  end
end
