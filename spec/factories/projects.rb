FactoryGirl.define do
  factory :project do
    payload { { hoge: "fuga" } }
    name "test_name"
  end
end
