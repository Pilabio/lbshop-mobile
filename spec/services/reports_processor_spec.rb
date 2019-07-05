require 'rails_helper'

RSpec.describe ReportsProcessor, type: :model do
  describe 'Call' do
    it 'calls GenerateReportService' do
      expect(GenerateReportService).to receive(:call)

      described_class.call
    end
  end
end
