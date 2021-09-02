class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  
  attachment :image
  
  enum is_active: { 販売中: true, 販売停止中: false }
  
  def add_tax_price
    (self.price * 1.10).round
  end
end
