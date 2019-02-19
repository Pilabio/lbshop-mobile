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
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(permitted_params)
      redirect_to products_path
    else
      render 'edit'
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

    redirect_to products_path
  end

  def last_sales
    @q = Product.ransack(params[:q])
    @products = @q.result.where(status: 'sold').order('sale_date DESC')

    render 'index', actual: 'last_sales'
  end

  private

  def permitted_params
    params.require(:product).permit(:name, :client_id, :kind, :entry_date, :price, :brand, :size)
  end
end
