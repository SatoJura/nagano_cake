class Public::ItemsController < ApplicationController
  def index
    @genre = Genre.all
    @items = Item.page(params[:page]).reverse_order
    @total = Item.count
  end

  def show
    @genre = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
