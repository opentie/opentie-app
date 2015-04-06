FactoryGirl.define do
  factory :project do
    payload { { email: "test@example.jp" } }
    name "test_name"
  end
end
