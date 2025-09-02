class CheckoutsController < ApplicationController
  before_action :load_checkout

  def show
    @items = @checkout.items
    @total = @checkout.total

    @grouped_items = @items.group_by(&:code).map do |code, items|
      product = items.first
      offer = Offer.find_by(product_id: product.id)
      subtotal = offer ? offer.apply(items) : items.sum(&:base_price)

      {
        product: product,
        quantity: items.size,
        offer: offer,
        subtotal: subtotal
      }
    end
  end


  def scan
    product = Product.find(params[:product_id])
    @checkout.scan(product)
    session[:checkout] = @checkout.items.map(&:id)
    

    flash[:notice] = "#{product.name} added to cart!"
    redirect_to checkout_path
  end

  def clear
    session[:checkout] = []
    flash[:notice] = "Cart cleared!"
    redirect_to checkout_path
  end

  private

  def load_checkout
    @checkout = Checkout.new
    if session[:checkout].present?
      session[:checkout].each do |product_id|
        product = Product.find(product_id)
        @checkout.scan(product)
      end
    end
  end

end