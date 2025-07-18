class DropProductsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :products
  end

  def down
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.timestamps null: false
    end
  end

  def change
  end
end
