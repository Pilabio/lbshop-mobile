module FormHelper
  def clients_collection
    Client.all.map { |client| ["(#{client.lbid}) #{client.name}", client.id] }
  end

  def product_status_collection
    Product::ACCEPTED_STATUS.map do |status|
      [I18n.t("views.product.status.#{status}"), status]
    end
  end

  def payment_method_collection
    methods = %w[credit debit cash]
    methods.map do |method|
      [I18n.t("views.product.payment_method.#{method}"), method]
    end
  end
end
