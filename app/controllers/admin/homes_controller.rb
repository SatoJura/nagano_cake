class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.page(params[:page]).reverse_order.per(12)
    @sum = 0
    # @order.order_details.each do |order_detail|
    #   @sum += order_detail.amount * order_detail.price
    # end
  end
end
