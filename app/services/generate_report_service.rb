module GenerateReportService
  class << self
    def call(client=nil, init_date, end_date, status)
      @client, @init_date, @end_date, @status = [client, init_date, end_date, status]

      format_dates! unless @client
      report = create_report!
      products = filter_products

      GenerateCsvService.call(products, report)
      ReportMailer.sales_report(client, report).deliver_later if @client
    end

    private

    def format_dates!
      @init_date = Date.parse(@init_date.values.join('-'))
      @end_date = Date.parse(@end_date.values.join('-'))
    end

    def create_report!
      Report.create!({
        name: generate_report_name,
        products_status: @status,
        init_date: @init_date,
        end_date: @end_date,
        client: @client
      })
    end

    def filter_products
      Product.ransack({
        status_cont: @status,
        client_id_eq: @client.try(:id),
        sale_date_gteq: @init_date.at_beginning_of_day,
        sale_date_lteq: @end_date.at_end_of_day
      }).result
    end

    def generate_report_name
      status = @status.empty? ? '' : "#{I18n.t("views.product.status.#{@status}")}"

      if @client
        "Relatório Automático (#{@client.name}) de #{I18n.l(@init_date, format: '%B')}"
      else
        "Relatório Manual (#{@status}) de #{I18n.l(@init_date)} à #{I18n.l(@end_date)}"
      end
    end
  end
end
