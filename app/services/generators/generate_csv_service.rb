module Generators
  module GenerateCsvService
    class << self
      require 'csv'

      def call(obj_array, resource)
        tmp_file = Tempfile.new([ 'csv_file', '.csv' ])

        CSV.open(tmp_file, 'wb', write_headers: true) do |csv|
          csv << headers

          obj_array.each do |obj|
            csv << fields.map do |attr|
              obj.send(attr)
            end
          end
        end

        resource.report_csv.attach(io: File.open(tmp_file), filename: "#{resource.name}.csv")
      end

      private

      def headers
        %w{Nome Valor}
      end

      def fields
        %w(name formatted_price)
      end
    end
  end
end
