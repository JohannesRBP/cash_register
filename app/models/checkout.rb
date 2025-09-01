class Checkout
  attr_reader :items

  def initialize
    @items = []
  end

  def scan(product)
    @items << product
  end

  def total
    @items.sum(&:base_price)
  end
end
