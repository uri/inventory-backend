require 'test_helper'

class Api::CheckoutsControllerTest < ActionController::TestCase

  setup do
    # !!!
    # move to factories
    user = User.create(
      email: 'bob@example.com',
      password: 'secret'
    )
    sign_in user
  end

  test 'succesfully create a checkout' do
    reservation = FactoryGirl.create(:reservation)
    assert_difference 'Checkout.count', 1 do
      post :create, format: :json, reservation_id: reservation.to_param
      assert_response :success
      checkout = assigns(:checkout)

      # pp checkout
      # assert_not_nil checkout.actual_user
    end
  end
end