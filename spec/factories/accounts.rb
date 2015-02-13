FactoryGirl.define do
  factory :account do
    name "test_user"
    email "example@example.jp"
    payload { { hoge: "fuga" } }
  end
end
