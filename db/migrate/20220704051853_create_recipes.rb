class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customer_id
      t.integer :post_id
      t.string :recipe_title
      t.integer :category, null: false, default: 0
      t.string :material

      t.timestamps
    end
  end
end
