require 'rails_helper'

RSpec.describe BogofOffer do
  let(:product) { Product.new(base_price: 10.0) }
  let(:offer) { BogofOffer.new }

  it 'charges for half the items (rounded up)' do
    items = [product, product, product]  # 3 items
    expect(offer.apply(items)).to eq(20.0)  # Pay for 2
  end
end

RSpec.describe BulkDiscountOffer do
  let(:product) { Product.new(base_price: 5.0) }
  let(:offer) { BulkDiscountOffer.new(threshold: 3, new_price: 4.0) }

  it 'applies discount when threshold met' do
    items = [product, product, product]
    expect(offer.apply(items)).to eq(12.0)  
  end

  it 'uses original price when below threshold' do
    items = [product, product]
    expect(offer.apply(items)).to eq(10.0)  
  end
end

RSpec.describe FractionalDiscountOffer do
  let(:product) { Product.new(base_price: 12.0) }
  let(:offer) { FractionalDiscountOffer.new(threshold: 3, factor_num: 2, factor_den: 3) }

  it 'applies fractional discount when threshold met' do
    items = [product, product, product]
    expected = 36.0 * 2.0 / 3  # 24.0
    expect(offer.apply(items)).to eq(expected)
  end
end