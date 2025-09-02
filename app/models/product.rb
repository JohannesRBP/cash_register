class Product < ApplicationRecord
  has_many :offers

  # Data validations
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :base_price, presence: true, numericality: { greater_than: 0 }
end
