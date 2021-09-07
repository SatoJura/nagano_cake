class Public::ItemsController < ApplicationController
  def index
    @genre = Genre.all
    @items = Item.all
  end

  def show
    @genre = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
