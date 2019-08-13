class ReportMailer < ApplicationMailer
  default from: 'no-reply@closetdagirafa.com'

  def sales_report(client, report)
    @report = report
    @client = client
    mail(to: @client.email, subject: "Relatório de vendas do mês de #{I18n.l(Date.today, format: "%B")}")
  end
end
