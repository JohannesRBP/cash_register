class BulkDiscountOffer < Offer

  def apply(items)
    if items.size >= threshold
      items.size * new_price
    else
      items.sum(&:base_price)
    end
  end
  
end