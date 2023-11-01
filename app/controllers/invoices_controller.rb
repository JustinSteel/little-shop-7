class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_merchant_id])
    @invoices = Invoice.invoices_for_merchant(@merchant.id)
  end
end