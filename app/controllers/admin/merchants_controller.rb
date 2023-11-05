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
end