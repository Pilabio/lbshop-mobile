module PayProductService
  class << self
    def update_payment(client)
      client.products.each do |product|
        if product.payment_status == 'pending' && product.sale_date == Date.today - 1.month
          product.update!(payment_status: 'ready')
          PaymentService.call(product)
        end
      end
    end
  end
end
