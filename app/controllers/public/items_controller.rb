class Public::ItemsController < ApplicationController
  def index
  end

  def show
    @genre = Genre.all
    @item = Item.find(params[:id])
  end

end
