class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre

  attachment :image

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true}

  def add_tax_price
    (self.price * 1.10).round
  end
end
