class ReportForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment

  attr_accessor :init_date, :end_date, :products_status

  def generate
    format_dates!
    report = create_report!
    products = filter_products

    GenerateCsvService.call(products, report)
    true
  rescue => e
    errors.add(:internal, 'Não foi possivel criar relatório');
    return nil
  end

  private

  def format_dates!
    @init_date = Date.parse(init_date.values.join('-'))
    @end_date = Date.parse(end_date.values.join('-'))
  end

  def create_report!
    Report.create!({
      name: generate_report_name,
      products_status: products_status,
      init_date: init_date,
      end_date: end_date
    })
  end

  def filter_products
    Product.ransack({
      status_cont: products_status,
      entry_date_gteq: init_date.at_beginning_of_day,
      entry_date_lteq: end_date.at_end_of_day
    }).result
  end

  def generate_report_name
    status = products_status.empty? ? '' : "#{I18n.t("views.product.status.#{products_status}")}"

    "Relatório Manual (#{status}) de #{I18n.l(init_date)} à #{I18n.l(end_date)}"
  end
end
