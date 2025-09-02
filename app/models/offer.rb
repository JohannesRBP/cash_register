class Offer < ApplicationRecord
  belongs_to :product

  #Data Validations
  validates :type, presence: true

  def apply(items)
    raise NotImplementedError, "Implement in subclass"
  end
end
