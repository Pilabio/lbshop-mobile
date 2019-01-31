class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @payments = Payment.all
  end
end
