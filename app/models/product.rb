class Product < ApplicationRecord
  belongs_to :brand, optional: true
  belongs_to :category, optional: true
end
