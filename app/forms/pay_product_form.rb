class PayProductForm
  include ActiveModel::Model
  include ActiveRecord::AttributeAssignment

  attr_accessor :sale_date, :product, :payment

  def set_payment
    @sale_date = Date.parse(@sale_date.values.join('-'))
    @product = Product.find(@product)

    update_product_payment
  end

  private

  def update_product_payment
    ActiveRecord::Base.transaction do
      @product.change_to_sold! unless @product.sold?
      @product.update(payment_method: @payment, sale_date: @sale_date)

      if @payment == 'cash' || @payment == 'debit'
        @product.payment_status = 'ready'
        PaymentService.call(@product)
      else
        @product.payment_status = 'pending'
      end

      @product.save
    end
  end
end
