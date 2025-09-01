class Offer < ApplicationRecord
  belongs_to :product

  def apply(items)
    raise NotImplementedError, "Implement in subclass"
  end
end
