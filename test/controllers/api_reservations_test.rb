require 'test_helper'

class Api::ReservationsControllerTest < ActionController::TestCase

  setup do
    @user = User.create(
      email: 'bob@example.com',
      password: 'secret'
    )
    sign_in @user
  end
  
  test 'create a reservation' do
    category = Category.create(name: 'Magic')
    item = Item.create(
      name: 'Magic bullet',
      category_id: category.id
    )
    assert_difference 'Reservation.count', 1 do
      post :create, format: :json, reservation: {
        item_id:   item.id,
        beginning: 3.days.from_now,
        ending:    5.days.from_now }
      assert_response :success
    end
  end
  

end
