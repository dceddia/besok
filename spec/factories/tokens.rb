# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :token do
    name "abcdefg"
    url "http://foo.com"
    description "This is for Foo"
    user_id 1
  end
end
