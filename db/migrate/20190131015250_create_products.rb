class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :status
      t.integer :price
      t.string :kind
      t.date :entry_date
      t.date :sale_date
      t.string :payment_method
      t.string :payment_status

      t.timestamps
    end
  end
end
