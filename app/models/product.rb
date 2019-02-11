class Product < ApplicationRecord
  include ProductStateMachine

  # :: Constants
  ACCEPTED_STATUS = %w[available sold unavailable].freeze

  # :: Relationships
  belongs_to :client

  # :: Callbacks
  before_create :set_lbid

  private

  def set_lbid
    products_lbid = self.client.products.count + 1
    self.lbid = sprintf '%03d', products_lbid
  end
end
