FactoryGirl.define do
  factory :division do
    name "test_name"
    payload { { hoge: "fuga" } }
  end
end
