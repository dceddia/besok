FactoryGirl.define do
  factory :user do |user|
    user.first_name{"John"}
    user.last_name  {"Doe"}
    sequence(:email) { |n| "jdoe#{n}@jdoe.me"}
    user.password {'secret'}
    sequence(:username) { |n| "jdoe#{n}"}
  end
end