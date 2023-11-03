class InvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(status: params[:status].to_i)
    redirect_to merchant_invoice_path(@invoice_item.merchant, @invoice_item.invoice)
  end

  private
  # Couldnt use strong params, MIGHT be able to if enums were a hash
  def invoice_item_params
    params.permit(:status)
  end
end