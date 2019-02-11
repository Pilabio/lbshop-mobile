class AddProductsAttrListToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :products_attr_list, :jsonb
  end
end
