class FixOffersNewPriceScale < ActiveRecord::Migration[8.0]
  def change
    change_column :offers, :new_price, :decimal, precision: 10, scale: 2
  end
end