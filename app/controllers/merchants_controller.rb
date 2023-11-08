class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:all)
  end
end
