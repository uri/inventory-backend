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

private

  def reservation_params
    params.require(:reservation).permit(
      :item_id,
      :beginning,
      :ending
    )
  end

end
