FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    email 'jdoe@jdoe.me'
    password 'secret'
    username "jdoe"
  end
end