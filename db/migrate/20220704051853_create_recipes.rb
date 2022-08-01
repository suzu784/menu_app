class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customer_id
      t.integer :post_id
      t.string :content
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
