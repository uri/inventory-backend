class Item < ActiveRecord::Base
  has_many :reservations
  has_many :categories
end
