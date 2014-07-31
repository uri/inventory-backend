FactoryGirl.define do
  factory :user do
    password              'sekrit'
    password_confirmation 'sekrit'
    sequence :email do |n|
      "user_#{n}@example.com"
    end
  end
end