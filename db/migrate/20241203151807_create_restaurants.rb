class CreateRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurants do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
