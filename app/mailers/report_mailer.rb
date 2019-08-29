class ReportMailer < ApplicationMailer
  default from: 'brechoclosetdagirafa@gmail.com'

  def sales_report(client, report)
    @report      = report.report_csv.blob.download
    @client      = client
    report_month = I18n.l(Date.today - 1.month, format: '%B')

    attachments["relatorio-#{report_month}.csv"] = {
      mime_type: 'text/csv',
      content: @report
    }

    mail(to: @client.email,
         subject: "Relatório de vendas do mês de #{report_month}")
  end
end
