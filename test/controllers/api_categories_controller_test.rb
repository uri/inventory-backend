require 'test_helper'

class Api::CategoriesControllerTest < ActionController::TestCase

  test 'show all categories' do
    Category.create(name: 'Headphones')
    get :index, format: :json
    response = JSON::parse(@response.body)
    assert response.any?
  end

  test 'create a category' do
    assert_difference 'Category.count', 1 do
      post :create, category: { name: 'Headphones' }, format: :json
      assert_response :success
    end
  end
  
end
