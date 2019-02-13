module PaymentService
  class << self
    def call
      Client.all.each do |client|
        create_payment(client)
      end
    end

    private

    def create_payment(client)
      payment = Payment.new

      payment.client = client
      payment.total_price = get_price(client)
      payment.price = payment.total_price / 2
      binding.pry
      payment.save
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
