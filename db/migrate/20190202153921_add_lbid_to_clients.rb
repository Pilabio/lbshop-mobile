class AddLbidToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :lbid, :string
  end
end
