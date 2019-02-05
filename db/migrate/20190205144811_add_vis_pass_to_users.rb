class AddVisPassToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :vis_pass, :string
  end
end
