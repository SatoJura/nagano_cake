class RemoveIsActiveFromCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :is_active, :boolean
  end
end
