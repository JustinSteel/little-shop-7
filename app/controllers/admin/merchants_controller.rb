class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def update
    merchant = Merchant.find(params[:id])
    if params["change"] == "name"
      merchant.update(name: params[:name])
      redirect_to admin_merchant_path(merchant)
      flash[:alert] = "Information has been successfully updated"
    else
      merchant.update(status: params[:status])
      redirect_to admin_merchants_path
    end
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to admin_merchants_path
      flash[:alert] = "Information has been successfully updated"
    else
      flash[:error] = "Error: All fields must be filled in to submit"
      redirect_to new_admin_merchant_path
    end
  end

  private

  def merchant_params
    params.permit(:id, :name, :status)
  end
end
