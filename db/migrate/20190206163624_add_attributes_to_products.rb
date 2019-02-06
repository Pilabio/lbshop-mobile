class AddAttributesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :name, :string
    add_column :products, :size, :string
    add_column :products, :brand, :string
  end
end
