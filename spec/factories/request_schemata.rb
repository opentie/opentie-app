FactoryGirl.define do
  factory :request_schema do
    payload { { hoge: "fuga" } }
  end
end
