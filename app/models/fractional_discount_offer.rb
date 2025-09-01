class FractionalDiscountOffer < Offer
  def apply(items)
    if items.size >= threshold
      items.sum(&:base_price) * factor_num.to_f / factor_den
    else
      items.sum(&:base_price)
    end
  end
end
