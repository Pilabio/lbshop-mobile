class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.page(params[:page])
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

  def pay_product
    PayProductForm.new(permitted_params).set_payment

    redirect_to products_path
  end

  def last_sales
    @q = Product.ransack(params[:q])
    @products = @q.result.where(status: 'sold').page(params[:page]).order('sale_date DESC')

    render 'index', actual: 'last_sales'
  end

  def return
    if params[:id]
      product = Product.find(params[:id])
      product.change_to_returned!
      redirect_to products_path, notice: 'O status foi alterado com sucesso'
    else
      redirect_to products_path, alert: 'O status não pode ser alterado, contacte pilabio por favor.'
    end
  end

  private

  def permitted_params
    params.require(:product).permit(:name, :client_id, :kind, :entry_date,
        :sale_date, :price, :brand, :size, :image, :product, :payment)
  end
end
