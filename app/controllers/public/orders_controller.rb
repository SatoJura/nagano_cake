class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if params[:order][:address_select] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:address_select] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else
      if params[:order][:postal_code] && params[:order][:address] && params[:order][:name].present?
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      else
        flash.now[:error]="必須項目を入力してください"
        render "new"
      end
    end
    @order.delivery_fee = 800
    @sum = @cart_items.sum(&:subtotal)
    @order.total_payment = @sum + @order.delivery_fee
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
    # cart_itemsから@order_detailに情報を移行し、cart_itemsを削除
      current_customer.cart_items.each do |cart_item|
        @order_detail = @order.order_details.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = cart_item.item.price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      @order = Order.new
      flash.now[:notice]="注文できませんでした。注文情報を入力してください。"
      render "new"
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id,:postal_code,:address,:name,:delivery_fee,:total_payment,:payment_method,:order_status)
  end
end
