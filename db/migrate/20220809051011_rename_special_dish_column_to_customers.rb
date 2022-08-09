class RenameSpecialDishColumnToCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :special_dish, :introduction
  end
end
