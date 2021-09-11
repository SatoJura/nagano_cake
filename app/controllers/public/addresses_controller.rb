class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice]="住所の登録が成功しました"
      redirect_to addresses_path
    else
      @addresses = current_customer.addresses
      flash.now[:notice]="住所の登録に失敗しました"
      render "index"
    end
  end

  def update
  end

  def destroy
  end

  private
  def address_params
    params.require(:address).permit(:address, :postal_code, :name)
  end
end
