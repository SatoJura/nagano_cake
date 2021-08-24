class Admin::ItemsController < ApplicationController
  def index
  end
  
  def new
    @item = Item.new
  end
  
  def create
    item = Item.new(item_params)
    item.save
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
  end
  
  private
  def item_params
    params.require(:item).permit(:name,:image,:introduction,:price,:is_active)
  end

end
