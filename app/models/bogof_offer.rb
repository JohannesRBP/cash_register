class BogofOffer < Offer
  
  def apply(items)
    count = items.size
    chargeable = (count + 1) / 2
    chargeable * items.first.base_price
  end
end