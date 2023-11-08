class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.integer :status, default: 0

      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
