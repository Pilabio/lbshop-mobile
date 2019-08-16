class ReportMailer < ApplicationMailer
  default from: 'brechoclosetdagirafa@gmail.com'

  def sales_report(client, report)
    @report = report
    @client = client
    mail(to: @client.email, subject: "Relatório de vendas do mês de #{I18n.l(Date.today-1.month, format: "%B")}")
  end
end
