module PaymentService
  class << self
    def call(product)
      @client = product.client

      unless product.client.payments.active.any?
        create_payment
      else
        update_payment(product)
      end
    end

    private

    def create_payment
      payment = Payment.new

      payment.client = @client
      payment.total_price = get_price(@client)
      payment.price = payment.total_price / 2

      payment.save
    end

    def update_payment(product)
      payment = @client.payments.active.first
      price = payment.total_price + product.price

      payment.update(total_price: price, price: price/2)
    end

    def get_price(client)
      price = 0
      client.products.each do |product|
        if product.sold? && product.payment_status == 'ready'
          price += product.price
        end
      end
      return price
    end
  end
end
