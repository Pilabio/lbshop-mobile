class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @payments = Payment.all.page(params[:page])
  end
end
