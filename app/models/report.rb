class Report < ApplicationRecord
  # :: Attachments
  has_one_attached :report_csv
end
