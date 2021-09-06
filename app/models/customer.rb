class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items
  has_many :orders
  has_many :addresses

  enum is_active: { 有効: true, 退会: false}

  def full_name
    self.last_name + " " + self.first_name
  end

  def full_name_kana
    self.last_name_kana + ' ' + self.first_name_kana
  end
end
