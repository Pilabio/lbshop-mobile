# frozen_string_literal: true

module PaymentStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm(:status) do
      state :active, initial: true
      state :unnactive

      event :change_to_unnactive do
        transitions from: :active, to: :unnactive
      end
    end
  end
end
