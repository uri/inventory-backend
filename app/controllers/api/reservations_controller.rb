class Api::ReservationsController < ApplicationController
  respond_to :json

  def index
    @reservations = Reservation.all
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    if @reservation.save
      respond_with @reservation
    else
      respond_with @reservation, status: :unprocessable_entity
    end
  end

  # def show
  #   @item = Item.find(params[:id])
  # end

  # def update
  #   @item = Item.find(params[:id])
  #   if @item.update_attributes(item_params)
  #     respond_with @item
  #   else
  #     respond_with @item, status: :unprocessable_entity
  #   end
  # end

  # def destroy
  #   @item = Item.find(params[:id])
  #   if @item.destroy
  #     head :ok
  #   else
  #     head :unprocessable_entity
  #   end
  # end

private

  def reservation_params
    params.require(:reservation).permit(
      :item_id,
      :beginning,
      :ending
    )
  end

end
