# frozen_string_literal: true

module ProductStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm(:status) do
      state :available, initial: true
      state :sold, :unavailable

      event :change_to_sold do
        transitions from: :available, to: :sold
      end

      event :chante_to_unavailable do
        transitions from: :available, to: :unavailable
      end
    end
  end
end
