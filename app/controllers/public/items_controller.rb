class Public::ItemsController < ApplicationController
  def index
    @genre = Genre.all
    # kaminari使うためall→page~に変更
    @items = Item.page(params[:page]).reverse_order.per(6)
    @total = Item.count
  end

  def show
    @genre = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

end
