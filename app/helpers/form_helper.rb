module FormHelper
  def clients_collection
    Client.all.map { |client| ["#{client.name}(#{client.lbid})", client.id] }
  end

  def product_status_collection
    Product::ACCEPTED_STATUS.map do |status|
      [I18n.t("views.product.status.#{status}"), status]
    end
  end
end
