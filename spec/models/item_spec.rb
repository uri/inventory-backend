require 'rails_helper'

describe Item do
  describe "relationships" do
    subject {  Item.new  }
    let(:current_reservation) {  subject.current_reservation  }

    it {  expect( subject ).to respond_to(:reservation)  }
    it {  expect( subject ).to respond_to(:category)  }

    it 'can get the current reservation' do
      expect( subject ).to respond_to(:current_reservation)
      expect( current_reservation ).class to_be(Reservation)
    end
  end

  describe 'attributes' do
    it {  expect( subject ).to respond_to(:name)  }
    it {  expect( subject ).to respond_to(:serial)  }
  end
end
