class ReportForm
  include ActiveModel::Model
  include Virtus.model

  validates :products_status, inclusion: { in: Product::ACCEPTED_STATUS }, if: -> { !products_status.nil? }
  validates :init_date, date: true
  validates :end_date, date: true

  attribute :init_date, Date
  attribute :products_status, String
  attribute :end_date, Date

  def generate
    return unless valid?

    report = create_report!
    products = filter_products

    GenerateCsvService.call(products, report)
  rescue => e
    errors.add('Não foi possivel criar relatório');
    return nil
  end

  private

  def create_report!
    Report.create!({
      name: generate_report_name,
      products_status: products_status,
      start_date: init_date,
      end_date: end_date
    })
  end

  def filter_products
    Product.ransack({
      status_cont: products_status,
      created_at_gteq: Date.parse(init_date),
      created_at_lteq: (end_date)
    }).result
  end

  def generate_report_name
    status = products_status ? "#{I18n.t("views.product.status.#{products_status}")} " : ''

    "Relatório Manual produtos #{status}de #{init_date} à #{end_date}"
  end
end
