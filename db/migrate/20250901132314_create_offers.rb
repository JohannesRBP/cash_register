class CreateOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :offers do |t|
      t.string :type
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
