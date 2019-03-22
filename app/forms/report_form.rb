class ReportForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment

  attr_accessor :init_date, :end_date, :products_status

  def generate
    GenerateReportService.call(init_date, end_date, products_status)
    true
  rescue => e
    errors.add(:internal, 'Não foi possivel criar relatório');
    return nil
  end
end
