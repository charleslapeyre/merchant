class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  PAYMENT_TYPES = ['Check', 'Credit Card', 'PayPal']

  validates :pay_type, inclusion: PAYMENT_TYPES

  # pull line items out of cart and add them to the order
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
    # remove the cart id
    item.cart_id = nil
    # add the order line items
    line_items << item
    end

  end
end
