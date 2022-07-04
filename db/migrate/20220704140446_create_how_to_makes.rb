class CreateHowToMakes < ActiveRecord::Migration[6.1]
  def change
    create_table :how_to_makes do |t|
      t.integer :recipe_id
      t.text :caption

      t.timestamps
    end
  end
end
