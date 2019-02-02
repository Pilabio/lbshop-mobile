class AddReferencesToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :client, index: true, foreign_key: true
  end
end
