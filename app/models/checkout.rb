class Checkout
  attr_reader :items

  def initialize
    @items = []
  end

  def scan(product)
    @items << product
  end

  def total
    total = 0

    # Group products by code
    grouped = @items.group_by(&:code)

    grouped.each do |code, products|
      # Find offer for that product
      offer = Offer.find_by(product_id: products.first.id)

      if offer
        total += offer.apply(products)
      else
        total += products.sum(&:base_price)
      end
    end

    total
  end

end
