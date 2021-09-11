class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.delivery_fee = 800
  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id,:postal_code,:address,:name,:delivery_fee,:total_payment,:payment_method,:order_status)
  end
end
