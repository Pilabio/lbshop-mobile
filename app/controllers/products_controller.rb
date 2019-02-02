class ProductsController < ApplicationController
  before_action :authenticate_user!

  def new
    @product = Product.new
    @client = Client.find(params[:client_id])
  end
end
