module GenerateReportService
  class << self
    def call(client, init_date, end_date, status, manual = false)
      variables = build_variables(client, init_date, end_date, status, manual)
      report    = create_report!(variables)
      products  = filter_products(variables)

      GenerateCsvService.call(products, report)
      ReportMailer.sales_report(client, report).deliver_later unless manual
    end

    private

    def create_report!(variables)
      Report.create!(
        name: generate_report_name(variables),
        products_status: variables[:status],
        init_date: variables[:init_date],
        end_date: variables[:end_date],
        client: variables[:client]
      )
    end

    def filter_products(variables)
      Product.ransack(
        status_cont: variables[:status],
        client_id_eq: variables[:client].id,
        sale_date_gteq: variables[:init_date].at_beginning_of_day,
        sale_date_lteq: variables[:end_date].at_end_of_day
      ).result
    end

    def generate_report_name(variables)
      client = variables[:client]
      status = variables[:status].empty? ? '' : "#{I18n.t("views.product.status.#{variables[:status]}")}"

      if !variables[:manual]
        "Relatório Automático (#{client.name}) de #{I18n.l(variables[:init_date], format: '%B')}"
      else
        "Relatório Manual (#{status}) de #{I18n.l(variables[:init_date])} à #{I18n.l(variables[:end_date])} (#{client.name})"
      end
    end

    def build_variables(client, init_date, end_date, status, manual)
      {
        client: client,
        init_date: init_date,
        end_date: end_date,
        status: status,
        manual: manual
      }
    end
  end
end
