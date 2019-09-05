class Client < ApplicationRecord
  # :: Pagination
  paginates_per 15

  # :: Relationships
  has_many :products
  has_many :payments
  has_many :reports

  # :: Callbacks
  before_create :set_lbid

  def any_sold_product?(init_date, end_date)
    return false if products.empty?

    sold_products = Product.where(client_id: id,
                                  sale_date: init_date..end_date,
                                  status: 'sold')
    sold_products.any? ? true : false
  end

  private

  def set_lbid
    self.lbid = Client.all.count + 10
  end
end
