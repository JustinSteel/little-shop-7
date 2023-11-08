class MerchantInvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:invoice_item])

    if params[:status] != @invoice_item.status
      @invoice_item.update(invoice_item_params)
      redirect_to merchant_invoice_path(@invoice_item.merchant, @invoice_item.invoice)
    else
      redirect_to merchant_invoice_path(@invoice_item.merchant, @invoice_item.invoice)
      flash[:alert] = "Status must be changed"
    end
  end

  private

  def invoice_item_params
    params[:status] = params[:status].to_i if params[:status].present?
    params.permit(:status)
  end
end
