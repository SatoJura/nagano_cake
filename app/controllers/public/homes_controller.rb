class Public::HomesController < ApplicationController
  def top
    @genre = Genre.all
    @items = Item.all
  end

  def about
  end
end
