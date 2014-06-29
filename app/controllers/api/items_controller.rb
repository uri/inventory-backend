class Api::ItemsController < ApplicationController
  respond_to :json

  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      respond_with @item
    else
      respond_with @item, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      respond_with @item
    else
      respond_with @item, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def checkout
    @item = Item.find_by_url_id(params[:url_id])
    @item.checkout_by(current_user)
    if @item.errors.any?
      respond_with @item
    else
      respond_with @item, status: :not_acceptable
    end
  end

private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :url_id)
  end

end
