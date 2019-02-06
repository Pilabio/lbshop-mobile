module FormHelper
  def clients_collection
    Client.all.map { |client| ["#{client.name}(#{client.lbid})", client.id] }
  end
end
