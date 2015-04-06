FactoryGirl.define do
  factory :account do
    name "test_name"
    email "test_name@example.jp"
    password "password"
    password_confirmation "password"
    payload { { hoge: "fuga"} }
  end
end
