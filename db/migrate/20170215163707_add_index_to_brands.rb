class AddIndexToBrands < ActiveRecord::Migration[5.0]
  def change
    add_index :brands, :name, unique: true
  end
end
