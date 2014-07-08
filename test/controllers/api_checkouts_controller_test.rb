require 'test_helper'

class Api::CheckoutsControllerTest < ActionController::TestCase

  test 'succesfully create a checkout' do
    reservation = FactoryGirl.create(:reservation)
    assert_difference 'Checkout.count', 1 do
      post :create, format: :json, reservation_id: reservation.to_param
      assert_response :success
    end
  end
end