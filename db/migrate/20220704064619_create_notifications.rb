class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :post_id
      t.integer :visiter_id
      t.integer :visited_id
      t.integer :post_comment_id
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
