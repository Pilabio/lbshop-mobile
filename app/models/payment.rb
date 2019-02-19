class Payment < ApplicationRecord
  include PaymentStateMachine

  belongs_to :client
end
