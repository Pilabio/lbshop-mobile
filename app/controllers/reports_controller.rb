class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Report.ransack(params[:q])
    @reports = @q.result
  end
end
