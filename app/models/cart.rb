class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # consolidate items by quantity. Adds to quantity if product is already in cart.
  # add new line item if product is not in the cart
  def add_product(product_id)
    product = Product.find(product_id)
    current_item = line_items.find_by(product_id: product_id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product, price: product.price)
    end

    current_item
  end

  def subtotal
    # SQL version. faster than ruby
    line_items.select("SUM(quantity * price) AS sum")[0].sum
    # ruby version
    # line_items.to_a.sum { |item| item.total }
  end
end
