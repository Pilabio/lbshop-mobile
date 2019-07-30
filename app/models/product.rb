class Product < ApplicationRecord
  include ProductStateMachine

  # :: Pagination
  paginates_per 15

  # :: Attachments
  has_one_attached :image

  # :: Constants
  ACCEPTED_STATUS = %w[available sold unavailable returned].freeze

  # :: Relationships
  belongs_to :client

  # :: Callbacks
  before_create :set_lbid

  private

  def set_lbid
    products_lbid = client.products.count + 1
    self.lbid = format '%03d', products_lbid
  end

  def formatted_price
    "R$ #{('%.2f' % (price.to_f / 100)).gsub('.', ',')}"
  end
end
