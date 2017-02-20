class Product < ApplicationRecord
  belongs_to :brand, optional: true
  belongs_to :category, optional: true
  has_many :line_items
  before_destory :ensure_not_referenced_by_any_item

  has_attached_file :avatar,
                    styles: { medium: "300x300#",
                              thumb: "100x100#" },
                    default_url: "missing_:style.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates_presence_of :name, :price, :quantity, :description, :brand, :category
  validates_numericality_of :price, greater_than_or_equal_to: 0.01
  validates_numericality_of :quantity, greater_than_or_equal_to: 0

  def self.search_by_name_or_description(string)
    # SQL query
    where("name LIKE ? OR description LIKE ?", "%#{string}%", "%#{string}%")
  end

  private
  # make sure there are not line items referencing this product.
  def ensure_not_referenced_by_any_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line item present')
      return false
    end
  end

end
