require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  
  context "with item that has no reservations" do

    setup do
      @item = FactoryGirl.create(:item)
    end

    should "have no reservations" do
      assert_nil @item.current_reservation
      assert_nil @item.next_reservation
    end

  end
end
