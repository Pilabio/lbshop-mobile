class Payment < ApplicationRecord
  include PaymentStateMachine

  # :: Pagination
  paginates_per 15

  belongs_to :client
end
