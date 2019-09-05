class Report < ApplicationRecord
  # :: References
  belongs_to :client

  # :: Pagination
  paginates_per 15

  # :: Attachments
  has_one_attached :report_csv
end
