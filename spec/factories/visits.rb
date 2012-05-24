# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :visit do
    ip_address "MyString"
    user_agent "MyString"
    referer "MyString"
    token_id 1
  end
end
