require 'rails_helper'

RSpec.describe Checkout do
  let(:checkout) { Checkout.new }
  let(:green_tea) { Product.create!(code: 'GR1', name: 'Green Tea', base_price: 3.11) }
  let(:strawberries) { Product.create!(code: 'SR1', name: 'Strawberries', base_price: 5.00) }
  let(:coffee) { Product.create!(code: 'CF1', name: 'Coffee', base_price: 11.23) }
  before do
      #Create offer BOGOF
      BogofOffer.create!(product: green_tea)
      #Create offer bulk discount (3+ strawberries at 4.50 each)
      BulkDiscountOffer.create!(product: strawberries, threshold: 3, new_price: 4.50)
      #Create offer fractional discount (3+ coffees at 2/3 price)
      FractionalDiscountOffer.create!(product: coffee, threshold: 3, factor_num: 2, factor_den: 3)
  end
  it 'starts with empy cart' do
    expect(checkout.items.size).to eq(0)
  end

  # 3 required tests (unit tests)
  describe 'required test cases' do 
    

    # Green Tea (BOGOF)
    it 'GR1, GR1 should equal 3.11€' do
      checkout.scan(green_tea)
      checkout.scan(green_tea)
      expect(checkout.total).to eq(3.11)
    end

    it 'GR1, GR1, GR1 should equal 6.22€' do
      checkout.scan(green_tea)
      checkout.scan(green_tea)
      checkout.scan(green_tea)
      expect(checkout.total).to eq(6.22)
    end

    # Strawberries (Bulk discount)
    it 'SR1, SR1 should equal 10.00€ (no discount)' do
      checkout.scan(strawberries)
      checkout.scan(strawberries)
      expect(checkout.total).to eq(10.00)
    end

    it 'SR1, SR1, SR1 should equal 13.50€ (discount applied)' do
      checkout.scan(strawberries)
      checkout.scan(strawberries)
      checkout.scan(strawberries)
      expect(checkout.total).to eq(13.50)
    end

    # Coffee (Fractional discount)
    it 'CF1, CF1 should equal 22.46€ (no discount)' do
      checkout.scan(coffee)
      checkout.scan(coffee)
      expect(checkout.total).to eq(22.46)
    end

    it 'CF1, CF1, CF1 should equal 22.46€ (3 with discount applied)' do
      checkout.scan(coffee)
      checkout.scan(coffee)
      checkout.scan(coffee)
      expect(checkout.total).to eq(22.46)
    end
  end

  describe "required cases (combined products, discount applied)" do
    #Coffe, strawberries, green_tea (Bulk discount)
    it "SR1, SR1, GR1, SR1 should equal 16.61€ (discount applied)" do
      checkout.scan(strawberries)
      checkout.scan(strawberries)
      checkout.scan(green_tea)
      checkout.scan(strawberries)
      expect(checkout.total).to eq(16.61)
    end
    #Coffe, strawberries, green_tea (Fractional discount)
    it "GR1, CF1, SR1, CF1, CF1 should equal 30.57€ (discount applied)" do
      checkout.scan(green_tea)
      checkout.scan(coffee)
      checkout.scan(strawberries)
      checkout.scan(coffee)
      checkout.scan(coffee)
      expect(checkout.total).to eq(30.57)
    end

  end

  describe "required cases (limits)" do
    # one green_tea
    it "GR1 should equal 3.11€" do
      checkout.scan(green_tea)
      expect(checkout.total).to eq(3.11)
    end

    # four coffes
    it "CF1, CF1, CF1,CF1 should equal 29.95 (discount applied)" do
      checkout.scan(coffee)
      checkout.scan(coffee)
      checkout.scan(coffee)
      checkout.scan(coffee)
      expect(checkout.total).to be_within(0.01).of(29.95)
    end
  end
    
end
