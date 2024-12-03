class CreateMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :menus do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
