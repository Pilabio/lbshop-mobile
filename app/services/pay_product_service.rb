module PayProductService
  class << self
    def call(product_id, payment_method)
      @product = Product.find(product_id)

      set_payment(payment_method)
      @product.change_to_sold!
    end

    def update_payment(client)
      client.products.each do |product|
        if product.payment_status == 'pending' && product.sale_date == Date.today - 1.month
          product.update!(payment_status: 'ready')
          PaymentService.call(product)
        end
      end
    end

    private

    def set_payment(method)
      @product.update(payment_method: method, sale_date: Date.today)

      if method == 'cash'
        @product.payment_status = 'ready'
        PaymentService.call(@product)
      else
        @product.payment_status = 'pending'
      end

      @product.save
    end
  end
end
