class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @sum = 0
    @order.order_details.each do |order_detail|
      @sum += order_detail.amount * order_detail.price
    end
  end

  def update
  end
end
