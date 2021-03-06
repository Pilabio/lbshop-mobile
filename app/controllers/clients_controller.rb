class ClientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @q = Client.ransack(params[:q])
    @clients = @q.result.page(params[:page])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(permitted_params)

    if @client.save
      redirect_to clients_path
    else
      render 'new'
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])

    if @client.update_attributes(permitted_params)
      redirect_to clients_path
    else
      render 'edit'
    end
  end

  def destroy
    client = Client.find(params[:id])

    client.destroy
    redirect_to clients_path
  end

  private

  def permitted_params
    params.require(:client).permit(:name, :email, :phone)
  end
end
