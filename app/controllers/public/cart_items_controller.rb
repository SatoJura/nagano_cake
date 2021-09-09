class Public::CartItemsController < ApplicationController
  def index
    # binding.pry
    @cart_items = current_customer.cart_items
    @total = @cart_items.sum(&:subtotal)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice]="個数を変更しました"
      redirect_to cart_items_path
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
      @cart_item.save
      flash[:notice]="商品を追加しました"
      redirect_to cart_items_path
    elsif @cart_item.save
      flash[:notice]="新しい商品を追加しました"
      redirect_to cart_items_path
    else
      @genre = Genre.all
      @item = Item.find(params[:cart_item][:item_id])
      render 'public/items/show'
    end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
