class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    @item = Item.find(params[:item_id])

    if @item.update(item_params)
      @item.save!
      redirect_to merchant_item_path(params[:merchant_id], params[:item_id])
    else
      flash.now[:alert] = "Invalid Field Input"  # flash.now is designed to be used when you are rendering, rather than redirecting
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit([:name, :description, :unit_price])
  end
end
