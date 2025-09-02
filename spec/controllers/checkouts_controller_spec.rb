require 'rails_helper'

RSpec.describe CheckoutsController, type: :controller do
  let!(:product) { Product.create!(code: 'GR1', name: 'Green Tea', base_price: 3.11) }

  describe 'POST #scan' do
    it 'adds product to session and redirects' do
      post :scan, params: { product_id: product.id }
      
      expect(session[:checkout]).to include(product.id)
      expect(response).to redirect_to(checkout_path)
      expect(flash[:notice]).to include('Green Tea added to cart!')
    end
  end

  describe 'POST #clear' do
    it 'clears the cart' do
      session[:checkout] = [product.id]
      
      post :clear
      
      expect(session[:checkout]).to eq([])
      expect(flash[:notice]).to eq('Cart cleared!')
    end
  end
end