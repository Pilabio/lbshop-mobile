class AddLbidToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :lbid, :string
  end
end
