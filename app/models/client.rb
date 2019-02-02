class Client < ApplicationRecord
  # :: Relationships
  has_many :products

  # :: Callbacks
  before_create :set_lbid

  private

  def set_lbid
    self.lbid = Client.all.count + 10
  end
end
