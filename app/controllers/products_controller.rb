class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    
    if params[:client_id]
      @client = Client.find(params[:client_id])
    else
      @client = false
    end
  end

  def create
    @product = Product.new(permitted_params)

    if @product.save
      redirect_to clients_path
    else
      render 'new'
    end
  end

  def attributes
    @user = current_user
    @attributes = current_user.products_attr_lists
  end

  def add_attributes
    attribute = params[:user][:products_attr_lists]
    current_user.products_attr_lists["#{params[:product_attr]}"] << attribute
    current_user.save
    redirect_to attributes_path
  end

  private

  def permitted_params
    params.require(:product).permit(:client_id, :kind, :entry_date, :price)
  end
end
