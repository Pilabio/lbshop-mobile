# frozen_string_literal: true

namespace :reports do
  task generate_reports: :environment do
    if Date.today == Date.today.at_beginning_of_month + 4
      Client.all.each do |client|
        init_date = (Date.today - 1.month).at_beginning_of_month
        end_date = Date.today

        GenerateReportService.call(client, init_date, end_date, '')
      end
    end
  end
end
