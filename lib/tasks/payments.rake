# frozen_string_literal: true

namespace :payments do
  task update_payment: :environment do
    Client.all.each do |client|
      PayProductService.update_payment(client)
    end
  end
end
