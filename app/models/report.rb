class Report < ApplicationRecord
  # :: Pagination
  paginates_per 15

  # :: Attachments
  has_one_attached :report_csv
end
