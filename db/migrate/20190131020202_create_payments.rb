class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :status
      t.integer :price

      t.timestamps
    end
  end
end
