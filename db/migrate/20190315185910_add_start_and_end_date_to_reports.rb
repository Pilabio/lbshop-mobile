class AddStartAndEndDateToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :init_date, :date
    add_column :reports, :end_date, :date
    add_column :reports, :products_status, :string
  end
end
