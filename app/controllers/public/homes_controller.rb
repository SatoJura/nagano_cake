class Public::HomesController < ApplicationController
  def top
    @genre = Genre.all
    @items = Item.page(params[:page]).reverse_order.per(3)
  end

  def about
  end
end
