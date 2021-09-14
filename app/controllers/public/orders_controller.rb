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
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
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
      redirect_to orders_thanks_path
    else
      @order = Order.new
      flash.now[:notice]="注文できませんでした。注文情報を入力してください"
      render "new"
    end
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
