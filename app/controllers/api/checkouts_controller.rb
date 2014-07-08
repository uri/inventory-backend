class Api::CheckoutsController < ApplicationController
  respond_to :json

  # POST /api/checkouts
  # params: { reservation_id: reservation_id }
  def create
    reservation = Reservation.find(params[:reservation_id])
    @checkout = Checkout.new
    @checkout.reservation = reservation
    if @checkout.save
      respond_with @checkout
    else
      respond_with @checkout, status: :unprocessable_entity
    end
  end

  def update
  end
end