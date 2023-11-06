class DefaultMerchantStatus < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:merchants, :status, 1)
  end
end
