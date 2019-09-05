class AddClientReferenceToReports < ActiveRecord::Migration[5.2]
  def change
    add_reference :reports, :client, foreign_key: true
  end
end
