class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @client = Client.find(params[:client_id])
  end

  def create
    @product = Product.new(permitted_params)

    if @product.save
      redirect_to clients_path
    else
      render 'new'
    end
  end

  private

  def permitted_params
    params.require(:product).permit(:client_id, :kind, :entry_date, :price)
  end
end
