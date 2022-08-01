class Destroy < ActiveRecord::Migration[6.1]
  def change
    drop_table :how_to_makes
  end
end
