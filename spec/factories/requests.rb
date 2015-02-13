FactoryGirl.define do
  factory :request do
    payload { hoge: "fuga" }.to_json
  end
end
