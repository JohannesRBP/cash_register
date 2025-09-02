require 'rails_helper'

RSpec.describe Product do
  it 'can be created with valid attributes' do
    product = Product.new(code: 'GR1', name: 'Green Tea', base_price: 3.11)
    expect(product).to be_valid
  end

  it 'has many offers' do
    product = Product.create!(code: 'GR1', name: 'Green Tea', base_price: 3.11)
    offer = BogofOffer.create!(product: product)
    
    expect(product.offers).to include(offer)
  end
end
