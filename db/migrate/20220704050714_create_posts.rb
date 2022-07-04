class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.string :cook_name
      t.text :opinion
      t.float :star
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
