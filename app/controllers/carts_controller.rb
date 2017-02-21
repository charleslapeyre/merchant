class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def edit
  end

  def destroy
    if @cart.destroy
      session[:cart_id] = nil
      flash[:notice] = "Your cart is now empty."
      redirect_to shop_path
    else
      flash[:alert] = "Sorry, we couldn't empty your cart."
      redirect_to edit_carts_path
    end
  end
end
