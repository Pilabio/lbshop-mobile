class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result
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
      redirect_back fallback_location: { action: "index" }
    else
      render 'new'
    end
  end

  def destroy
    product = Product.find(params[:id])

    product.destroy
    redirect_to products_path
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

  def delete_attribute
    attribute = params[:attribute]
    attr_list_array = current_user.products_attr_lists[attribute].split(' ')
    attr_list_array.pop

    current_user.products_attr_lists[attribute] = attr_list_array.join(' ')
    current_user.save
    redirect_to attributes_path
  end

  def pay_product
    PayProductService.call(params[:product], params[:payment])

    redirect_back fallback_location: { action: "index" }
  end

  private

  def permitted_params
    params.require(:product).permit(:client_id, :kind, :entry_date, :price)
  end
end
