class Genre < ApplicationRecord
  has_many :items

  validates :name, presence: true
  
  def self.serch(serch)
    if serch
      Genre.where(['name LIKE ?', "%#{serch}%"])
    else
      Genre.all
    end
  end

end
