FactoryGirl.define do
  factory :account_factory, class: Account do
    name "test_user"
    email "example@example.jp"
    payload { hoge: fuga }
  end
end
