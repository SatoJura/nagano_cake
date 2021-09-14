class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }

  validates :payment_method, presence: true
  validates :total_payment, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true
  validates :name, presence: true

end