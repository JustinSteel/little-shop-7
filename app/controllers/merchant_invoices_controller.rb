class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.invoices_for_merchant(@merchant.id)
  end

  def show

  end
end