class AddAttributesToOffers < ActiveRecord::Migration[8.0]
  def change
    add_column :offers, :threshold, :integer
    add_column :offers, :new_price, :decimal
    add_column :offers, :factor_num, :integer
    add_column :offers, :factor_den, :integer
  end
end
