class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients
      t.text :method
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
