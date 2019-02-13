class AddTotalPriceToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :total_price, :integer
  end
end
