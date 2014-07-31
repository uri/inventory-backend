require 'test_helper'

class Api::CheckoutsControllerTest < ActionController::TestCase

  setup do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  should 'succesfully create a checkout' do
    reservation = FactoryGirl.create(
      :reservation,
      beginning: 5.minutes.ago,
      ending:    1.hour.from_now,
      user:      @user
    )
    assert_difference 'Checkout.count', 1 do
      post :create, format: :json, reservation_id: reservation.to_param
      checkout = assigns(:checkout)
      assert_response :success
    end
  end
end