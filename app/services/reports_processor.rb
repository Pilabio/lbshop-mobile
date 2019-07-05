module ReportsProcessor
  class << self
    def call()
      report = GenerateReportService.call

      csv = GenerateCsvService.call
      # SendReportMailWorker.perform_later
    end
  end
end
