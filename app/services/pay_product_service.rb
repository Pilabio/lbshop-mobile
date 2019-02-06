module PayProductService
  class << self
    def call(product_id, payment_method)
      @product = Product.find(product_id)

      set_payment(payment_method)
      @product.change_to_sold!
    end

    private

    def set_payment(method)
      @product.update(payment_method: method, sale_date: Date.today)

      if method == 'cash'
        @product.payment_status = 'ready'
      else
        @product.payment_status = 'pending'
      end

      @product.save
    end
  end
end
