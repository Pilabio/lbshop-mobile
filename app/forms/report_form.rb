class ReportForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment

  attr_accessor :init_date, :end_date, :products_status, :client_id

  def generate
    client = Client.find(client_id)
    format_dates!

    if client
      GenerateReportService.call(
        client, @init_date, @end_date, products_status, true
      )
      return true
    end
  rescue => e
    errors.add(:internal, 'Não foi possivel criar relatório')

    nil
  end

  private

  def format_dates!
    @init_date = Date.parse(@init_date.values.join('-'))
    @end_date = Date.parse(@end_date.values.join('-'))
  end
end
