FactoryGirl.define do
  factory :reservation do
    item
    user
    beginning 1.week.from_now
    ending    2.weeks.from_now
  end
end