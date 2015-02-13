FactoryGirl.define do
  factory :request_schema do
    payload { hoge: "fuga" }.to_json
  end
end
